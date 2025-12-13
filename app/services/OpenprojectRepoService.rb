class OpenprojectRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.openproject.org/docs/release-notes/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h2').collect{|x| [x.text.to_s.strip, 'https://www.openproject.org/docs/release-notes/' + x.css('a').last.attributes["href"].value] }.compact
    last_release = release_arr.first
    return last_release
  end
end
