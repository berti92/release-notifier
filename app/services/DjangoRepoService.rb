class DjangoRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://pypi.org/rss/project/django/releases.xml")
    response = Net::HTTP.get_response(uri)
    xml = response.body
    parsed_xml = Nokogiri::XML(xml)
    return [parsed_xml.xpath('//item/title').first.text, "https://docs.djangoproject.com/en/"]
  end
end
