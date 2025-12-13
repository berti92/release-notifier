class MongodbRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.mongodb.com/docs/manual/release-notes/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.main-column a').collect{|x| [x.text.to_s.strip, "https://www.mongodb.com" + x.attributes["href"].value] if(x.text.to_s.downcase.include?('release notes'))}.compact.uniq
    last_release = release_arr.first
    return last_release
  end
end