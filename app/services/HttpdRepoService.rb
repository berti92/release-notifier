class HttpdRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://httpd.apache.org/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h1').collect{|x| [x.text.to_s.strip, "https://httpd.apache.org/"] if(x.text.to_s.strip.include?('Released'))}.compact
    last_release = release_arr.first
    return last_release
  end
end