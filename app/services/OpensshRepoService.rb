class OpensshRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.openssh.com/releasenotes.html")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h3 a:last-child').collect{|x| [x.text.to_s.strip, 'https://www.openssh.com/' + x.attributes["href"].value] }.compact
    last_release = release_arr.first
    return last_release
  end
end