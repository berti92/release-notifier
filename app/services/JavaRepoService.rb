class JavaRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    url = "https://www.java.com/releases/"
    browser = Watir::Browser.new :chrome, headless: true
    browser.goto(url)
    sleep(4) # Time to render
    parsed_html = Nokogiri::HTML.parse(browser.html)
    release_arr = parsed_html.css('tbody#released tr:nth-child(4) td:nth-child(4) a').collect{|x| [x.text.to_s.strip, x.attributes["href"].value]}
    last_release = release_arr.first
    return last_release
  end
end
