class PostgresRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.postgresql.org/docs/release/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.release-notes-list > li > ul > li a').collect{|x| [x.text.to_s.strip, 'https://www.postgresql.org' + x.attributes["href"].value]}
    last_release = release_arr.first
    return last_release
  end
end