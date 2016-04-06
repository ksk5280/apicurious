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
    data.map do |repo|
      repo.name
    end
  end

  def starred_repos(user)

  end

  def followers(user)
    binding.pry
    User.service.followers(user)
  end
end
