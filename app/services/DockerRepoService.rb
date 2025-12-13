class DockerRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://docs.docker.com/engine/release-notes/")
    response = Net::HTTP.get_response(uri)
    if response.code == "301" || response.code == "302"
      response = Net::HTTP.get_response(URI.parse("https://docs.docker.com" + response['location']))
    end
    html = response.body
    parsed_html = Nokogiri::HTML.parse(html)
    release_arr = parsed_html.css('h2').collect{|x| [x.text.to_s.strip, 'https://docs.docker.com/engine/release-notes/']}
    last_release = release_arr.first
    return last_release
  end
end