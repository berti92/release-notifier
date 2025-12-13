class OpnSenseRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://opnsense.org/about/road-map/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h1').collect{|x| [x.text.to_s.strip, "https://opnsense.org/about/road-map/"] if(x.text.to_s.strip.downcase.include?('latest release'))}.compact
    last_release = release_arr.first
    return last_release
  end
end