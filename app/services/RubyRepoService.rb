class RubyRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.ruby-lang.org/en/downloads/releases/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = [] 
    parsed_html.css('table.release-list tr').each do |row|
        next if row.css('td').first.nil?
        next if row.css('td').first.text.to_s.include?('preview') || row.css('td').first.text.to_s.include?('rc')
        release_row = []
        release_row << row.css('td').first.text.to_s
        release_row << 'https://www.ruby-lang.org' + row.css('td a').last.attributes["href"].value
        release_arr << release_row
    end
    last_release = release_arr.first
    return last_release
  end
end