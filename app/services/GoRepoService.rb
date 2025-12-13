class GoRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://go.dev/doc/devel/release")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h2').collect{|x| [x.text.to_s.strip, 'https://go.dev/doc/devel/release#' + x.attributes["id"].value] if(x.text.to_s.include?('released'))}.compact.uniq
    last_release = release_arr.first
    return last_release
  end
end