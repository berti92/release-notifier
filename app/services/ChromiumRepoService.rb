class ChromiumRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.gitclear.com/open_repos/chromium/chromium/releases")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.git_tags_table .version_column a:first-child').collect{|x| [x.text.to_s.strip, "https://www.gitclear.com" + x.attributes["href"].value] if(!x.text.to_s.downcase.include?('upcoming') && !x.text.to_s.downcase.include?('previous'))}.compact
    last_release = release_arr.first
    return last_release
  end
end