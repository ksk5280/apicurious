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
    # binding.pry
    GithubService.new(user)
  end

  def repos(user)
    User.service(user).repos
  end

  def orgs(user)
    User.service(user).orgs
  end

  def starred_repos(user)
    User.service(user).starred_repos
  end

  def followers(user)
    User.service(user).followers
  end

  def following(user)
    User.service(user).following
  end

  def events(user)
    User.service(user).events
  end

  def followed_events(followed_username)
    User.service(user).followed_events(followed_username)[0..9]
  end

  def contributions_in_last_year(user)
    User.service(user).contributions_in_last_year
  end

  def longest_streak(user)
    User.service(user).longest_streak
  end

  def current_streak(user)
    User.service(user).current_streak
  end

  private

    def user
      @_user
    end
end
