class PythonRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.python.org/downloads/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.list-row-container .release-number a').collect{|x| [x.text.to_s.strip, 'https://www.python.org' + x.attributes["href"].value]}
    last_release = release_arr.first
    return last_release
  end
end