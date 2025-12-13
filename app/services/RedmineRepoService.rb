class RedmineRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    url = 'https://github.com/redmine/redmine/releases.atom'
    rel_title = nil
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      last_release = feed.items.first rescue nil
      rel_title = last_release.title.content rescue nil
    end
    last_release = [rel_title, 'https://redmine.org/projects/redmine/wiki/Changelog']
    return last_release
  end
end
