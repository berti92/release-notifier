class MysqlRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://dev.mysql.com/doc/relnotes/mysql/8.0/en/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.toc span.section a').collect{|x| [x.text.to_s.strip, 'https://dev.mysql.com/doc/relnotes/mysql/8.0/en/' + x.attributes["href"].value] if(!x.text.to_s.downcase.include?('not yet released') && x.text.to_s.downcase.include?('changes in'))}.compact
    last_release = release_arr.first
    return last_release
  end
end