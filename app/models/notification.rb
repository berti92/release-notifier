class Notification < ApplicationRecord
    include Hashid::Rails
    require 'net/http'
    require 'uri'
    belongs_to :repository
    enum repo_type: Repository.repo_types
    WEBHOOK_METHODS = [
        :POST,
        :PUT,
        :GET,
        :PATCH,
        :DELETE
    ]
    validates :name, presence: true
    validates :repo, presence: true
    before_validation :set_repository

    def normalize_repo
        self.repo = self.repo.split('/')[-2..-1].join('/') rescue 'wrong_repo/format'
    end

    def self.sorted_options_for_select
        options = []
        options << [I18n.t('repo_types.github'), Notification.repo_types.keys.first]
        options += Notification.repo_types.map {|key, value| [I18n.t('repo_types.' + key), Notification.repo_types.key(value)] if(key != "github")}.compact.sort{|k,v| k[0].downcase <=> v[0].downcase}
    end

    def set_repository
        self.normalize_repo
        repo = Repository.find_by(repo_type: self.repo_type, repo: self.repo)
        if repo.nil?
            repo = Repository.create(repo_type: self.repo_type, repo: self.repo)
        end
        self.repository = repo
    end

    def repo_url
        rurl = ''
        if self.repo_type.to_s == 'github'
            rurl = 'https://github.com/' + self.repo + '/releases'
        else
            #REPO-TYPE NOT IMPLEMENTED
        end
        return rurl
    end

    def send_to_webhook(link)
        repo_name = self.repo
        if repo_name.blank? || repo_name == 'wrong_repo/format'
            repo_name = I18n.t('repo_types.' + self.repo_type)
        end
        release_msg = "The repository #{repo_name} released a new version! With the following link, you can see the exact release notes: #{link}"
        case self.webhook_method
        when 'POST'
            uri = URI.parse(self.webhook_url)
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Post.new(uri.request_uri, header)
            request.body = self.webhook_payload.gsub('##RELEASE_MSG##',release_msg)
            response = http.request(request)
        when 'PUT'
            uri = URI.parse(self.webhook_url)
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Put.new(uri.request_uri, header)
            request.body = self.webhook_payload.gsub('##RELEASE_MSG##',release_msg)
            response = http.request(request)
        when 'GET'
            uri = URI.parse(self.webhook_url.gsub('##RELEASE_MSG##',release_msg))
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            response = Net::HTTP::Get(uri.request_uri)
        when 'PATCH'
            uri = URI.parse(self.webhook_url)
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Patch.new(uri.request_uri, header)
            request.body = self.webhook_payload.gsub('##RELEASE_MSG##',release_msg)
            response = http.request(request)
        when 'DELETE'
            uri = URI.parse(self.webhook_url)
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Delete.new(uri.request_uri, header)
            request.body = self.webhook_payload.gsub('##RELEASE_MSG##',release_msg)
            response = http.request(request)
        else
            uri = URI.parse(self.webhook_url)
            header = {'Content-Type': self.webhook_content_type}
            http = Net::HTTP.new(uri.host, uri.port)
            http.use_ssl = uri.scheme == 'https'
            request = Net::HTTP::Post.new(uri.request_uri, header)
            request.body = self.webhook_payload.gsub('##RELEASE_MSG##',release_msg)
            response = http.request(request)
        end
    end

    def notify(link)
        if !self.email.blank?
            NotificationMailer.notify_mail(self, link).deliver if BlockedMail.where(mail_address: self.email).count == 0
        end
        if !self.webhook_url.blank? && !self.webhook_method.blank?
            self.send_to_webhook(link)
        end
        self.update(last_release: self.repository.last_release )
    end
end
