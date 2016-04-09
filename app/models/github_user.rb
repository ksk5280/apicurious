class GithubUser
  def initialize(user)
    @user = user
  end

  def service
    @service ||= GithubService.new(user)
  end

  def repos
    service.repos
  end

  def orgs
    service.orgs
  end

  def starred_repos
    service.starred_repos
  end

  def followers
    service.followers
  end

  def following
    service.following
  end

  def events
    service.events
  end

  def followed_events(followed_username)
    service.followed_events(followed_username)[0..9]
  end

  def contributions_in_last_year
    service.contributions_in_last_year
  end

  def longest_streak
    service.longest_streak
  end

  def current_streak
    service.current_streak(user)
  end
end
