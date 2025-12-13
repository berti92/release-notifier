class FirefoxRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://www.mozilla.org/en-US/firefox/releases/")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('.c-release-list li a:last-child').collect{|x| [x.text.to_s.strip, "https://www.mozilla.org/en-US/firefox/releases/" + x.attributes["href"].value]}.compact
    release_arr = release_arr.sort_by { |v| (v[0].split('.')[0].to_i.to_s + '.' + v[0].split('.')[1].to_i.to_s + v[0].split('.')[2].to_i.to_s + v[0].split('.')[3].to_i.to_s).to_f  }
    last_release = release_arr.first
    return last_release
  end
end