class WordpressRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://wordpress.org/download/releases/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('#latest .wp-block-wporg-release-tables__cell-version').collect{|x| [x.text.to_s.strip, 'https://wordpress.org/news/category/releases/'] if(x.text.to_s.strip.downcase != 'version')}.compact
    last_release = release_arr.first
    return last_release
  end
end