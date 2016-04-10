class User < ActiveRecord::Base
  # def initialize(user)
  #   @_user = user
  # end

  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |new_user|
      new_user.uid          = auth_info.uid
      new_user.name         = auth_info.info.name
      new_user.username     = auth_info.info.nickname
      new_user.oauth_token  = auth_info.credentials.token
      new_user.profile_pic  = auth_info.info.image
    end
  end

  def self.service(user)
    GithubService.new(user)
  end

  def repos(user)
    User.service.repos(user)
  end

  def orgs(user)
    User.service.orgs(user)
  end

  def starred_repos(user)
    User.service.starred_repos(user)
  end

  def followers(user)
    User.service.followers(user)
  end

  def following(user)
    User.service.following(user)
  end

  def events(user)
    User.service.events(user)
  end

  def followed_events(followed_username)
    User.service.followed_events(followed_username)[0..9]
  end

  def contributions_in_last_year
    User.service.contributions_in_last_year(user)
  end

  def longest_streak
    User.service.longest_streak(user)
  end

  def current_streak
    User.service.current_streak(user)
  end

  private

    def user
      @_user
    end
end
