require 'rails_helper'

RSpec.describe User, type: :model do
  attr_reader :user

  before(:each) do
    @user = User.new
    @user.oauth_token = ENV["OAUTH_TOKEN"]
    @user.username = "ksk5280"
  end

  it "returns a collection of repositories" do
    VCR.use_cassette "user.repo" do
      repos = user.repos(user)
      repo  = repos.first

      expect(repo.name).to eq("active-record-sinatra")
      expect(repos.count).to eq(30)
    end
  end

  it "returns a collection of starred repositories" do
    VCR.use_cassette "user.starred_repos" do
      repos = user.starred_repos(user)
      repo  = repos.first

      expect(repo.name).to eq("apicurious")
      expect(repos.count).to eq(1)
    end
  end

  it "returns a collection of followers" do
    VCR.use_cassette "user.followers" do
      followers = user.followers(user)
      follower  = followers.first

      expect(follower.login).to eq("hkang1")
      expect(followers.count).to eq(12)
    end
  end

  it "returns a collection of users being followed" do
    VCR.use_cassette "user.following" do
      followed_users = user.following(user)
      followed_user  = followed_users.first

      expect(followed_user.login).to eq("hkang1")
      expect(followed_users.count).to eq(16)
    end
  end
end
