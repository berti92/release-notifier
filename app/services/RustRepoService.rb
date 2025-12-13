class RustRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://releases.rs/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.book-menu-content ul a').collect{|x| [x.text.to_s.strip, 'https://releases.rs' + x.attributes["href"].value]}
    last_release = release_arr.first
    return last_release
  end
end