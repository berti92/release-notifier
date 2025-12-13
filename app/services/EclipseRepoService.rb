class EclipseRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://projects.eclipse.org/releases")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('article ul a').collect{|x| [x.text.to_s.strip, x.attributes["href"].value]}.compact
    last_release = release_arr.first
    return last_release
  end
end