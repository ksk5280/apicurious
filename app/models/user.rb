class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid          = auth_info.uid
      new_user.name         = auth_info.info.name
      new_user.username     = auth_info.info.nickname
      new_user.oauth_token  = auth_info.credentials.token
      new_user.profile_pic  = auth_info.info.image
    end
  end

  def self.service
    GithubService.new
  end

  def repos(user)
    data = User.service.repos(user)
    data.map(&:name)
  end

  def repo_count(user)
    repos(user).count
  end

  def orgs(user)
    data = User.service.orgs(user)
    data.map(&:name)
  end

  def org_count(user)
    orgs(user).count
  end

  def starred_repos(user)
    data = User.service.starred_repos(user)
    data.map(&:name)
  end

  def starred_repo_count(user)
    User.service.starred_repos(user).count
  end

  def followers(user)
    data = User.service.followers(user)
    data.map(&:login)
  end

  def follower_count(user)
    followers(user).count
  end

  def following(user)
    data = User.service.following(user)
    data.map(&:login)
  end

  def following_count(user)
    following(user).count
  end

  def event_type(user)
    User.service.events(user)
  end
end
