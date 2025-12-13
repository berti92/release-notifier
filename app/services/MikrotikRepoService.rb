class MikrotikRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://mikrotik.com/download/changelogs")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('#tab-tree_2 ul li a').collect{|x| [x.text.to_s.strip, "https://mikrotik.com/download/changelogs"]}.compact
    last_release = release_arr.first
    return last_release
  end
end