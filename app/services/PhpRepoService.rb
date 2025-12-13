class PhpRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.php.net/ChangeLog-8.php")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('section.version h3').collect{|x| [x.text.to_s.strip, 'https://www.php.net/ChangeLog-8.php']}
    last_release = release_arr.first
    return last_release
  end
end