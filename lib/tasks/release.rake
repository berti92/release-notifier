require 'rss'

namespace :release do
  desc "Check for releases"
  task :check => :environment do
    Repository.all.each do |repo|
      unless repo.notifications.exists?
        puts "Repo with ID #{repo.id} skipped, because no notification exists for this"
        next
      end

      begin
        rel_title = nil
        rel_link = nil
        if repo.repo_type.to_s == 'github' || repo.repo_type.to_s.starts_with?('github')
          repo_name = repo.repo.to_s
          repo_name = Repository::REPO_LIST[repo.repo_type.to_sym] if repo.repo_type.to_s != 'github'
          url = 'https://github.com/' + repo_name + '/releases.atom'
          puts 'Check Repo: ' + repo_name + ' #' + repo.id.to_s
          URI.open(url) do |rss|
            feed = RSS::Parser.parse(rss)
            last_release = feed.items.first rescue nil
            rel_title = last_release.title.content rescue nil
            rel_link = last_release.link.href
          end
        else
          repo_service = "#{repo.repo_type.camelize}RepoService".constantize.new(repo)
          release_arr = repo_service.get_release
          rel_title = release_arr[0] rescue nil
          rel_link = release_arr[1] rescue nil
        end
        # Send notifications
        if !rel_title.blank? && !rel_link.blank?
          puts 'Release title: ' + rel_title.to_s
          repo.update(last_checked: DateTime.current, last_release: rel_title)
          repo.notifications.where(["last_release <> ? OR last_release is null", rel_title]).each do |notification|
            if notification.stop_words.to_s.downcase.split(',').collect{|x| x if rel_title.downcase.include?(x)}.compact.length > 0
              puts 'Skipped Notification, because of stop word #'+notification.id.to_s
            else
              puts 'Notification #'+notification.id.to_s
              notification.notify(rel_link)
            end
          end
        end
      rescue Exception => ex
        puts 'Exception: ' + ex.message.to_s
      end
    end
  end
end
