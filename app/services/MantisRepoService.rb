class MantisRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://mantisbt.org/blog/archives/tag/release")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('article h2 a').collect{|x| [x.text.to_s.strip, x.attributes["href"].value] if(x.text.to_s.include?('released'))}.compact
    last_release = release_arr.first
    return last_release
  end
end