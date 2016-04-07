require "rails_helper"

RSpec.describe GithubService do
  attr_reader :service, :user

  before(:each) do
    @service = GithubService.new
    @user = User.new
    @user.oauth_token = ENV["OAUTH_TOKEN"]
    @user.username = "ksk5280"
  end

  context ".repositories" do
    it "returns current user repositories" do
      VCR.use_cassette("github_service.repos") do
        repos = service.repos(user)
        repo  = repos.first

        expect(repo[:name]).to eq("active-record-sinatra")
        expect(repos.count).to eq(30)
      end
    end
  end

  context ".organizations" do
    it "returns current user's orgs" do
      VCR.use_cassette("github_service.orgs") do
        orgs = service.orgs(user)

        expect(orgs.count).to eq(0)
      end
    end
  end

  context ".followers" do
    it "returns current user's followers" do
      VCR.use_cassette("github_service.followers") do
        followers = service.followers(user)
        follower  = followers.first

        expect(follower[:login]).to eq("hkang1")
        expect(followers.count).to eq(12)
      end
    end
  end

  context ".following" do
    it "returns users the current user is following" do
      VCR.use_cassette("github_service.following") do
        followings = service.following(user)
        following  = followings.first

        expect(following[:login]).to eq("hkang1")
        expect(followings.count).to eq(16)
      end
    end
  end

  context ".starred_repos" do
    it "returns current user's starred_repos" do
      VCR.use_cassette("github_service.starred_repos") do
        starred_repos = service.starred_repos(user)
        starred_repo  = starred_repos.first

        expect(starred_repo[:name]).to eq("apicurious")
        expect(starred_repos.count).to eq(1)
      end
    end
  end

  context ".events" do
    it "returns current user's events" do
      VCR.use_cassette("github_service.events") do
        events = service.events(user)
        event  = events.first

        expect(event[:actor][:login]).to eq("ksk5280")
        expect(events.count).to eq(30)
      end
    end
  end

  context ".contributions_in_last_year" do
    it "returns current user's total number of contributions" do
      VCR.use_cassette("github_service.contributions_in_last_year") do
        contributions = service.contributions_in_last_year(user)

        expect(contributions).to eq("645 total")
      end
    end
  end

  context ".longest_streak" do
    it "returns current user's longest streak" do
      VCR.use_cassette("github_service.longest_streak") do
        long_streak = service.longest_streak(user)

        expect(long_streak).to eq("35 days")
      end
    end
  end

  context ".current_streak" do
    it "returns current user's current streak" do
      VCR.use_cassette("github_service.current_streak") do
        current = service.current_streak(user)

        expect(current).to eq("4 days")
      end
    end
  end
  # context ".followed_events" do
  #   it "returns events from the users being followed" do
  #     VCR.use_cassette("github_service.followed_events") do
  #       followed_user   = @service.following(@user)[1].login
  #       followed_events = @service.followed_events(followed_user)
  #       followed_event  = followed_events.first
  #
  #       expect(followed_event[:actor][:login]).to eq("julesfec")
  #       expect(followed_events.count).to eq(30)
  #     end
  #   end
  # end
end
