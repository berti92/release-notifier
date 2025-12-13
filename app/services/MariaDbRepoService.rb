class MariaDbRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://mariadb.org/mariadb/all-releases/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = [] 
    parsed_html.css('.page-content tr').each do |row|
        next if row.css('td').last.nil? || !row.css('td').last.text.to_s.downcase.include?('stable')
        release_row = []
        release_row << row.css('td a').first.text.to_s
        release_row << row.css('td a').first.attributes["href"].value
        release_arr << release_row
    end
    last_release = release_arr.first
    return last_release
  end
end