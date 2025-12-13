class GitlabRunnerRepoService
  def initialize(repo)
    @repo = repo
  end

  def get_release
    uri = URI.parse("https://gitlab.com/gitlab-org/gitlab-runner/-/raw/main/CHANGELOG.md")
    response = Net::HTTP.get_response(uri)
    release_arr = []
    response.body.each_line {|x| release_arr << [x.strip, "https://gitlab.com/gitlab-org/gitlab-runner/-/raw/main/CHANGELOG.md"] if x.starts_with?('## ')}
    last_release = release_arr.first
    return last_release
  end
end