class SymfonyStableRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://symfony.com/releases.json")
    response = Net::HTTP.get_response(uri)
    html = response.body
    parsed_json = JSON.parse(html)
    return [parsed_json["symfony_versions"]["stable"], "https://symfony.com/releases"]
  end
end
