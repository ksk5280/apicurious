require "rails_helper"

describe GithubService do
  context '.repositories' do
    it "returns current user repositories" do
      VCR.use_cassette("github_service.repos") do
        service = GithubService.new
        user = User.new
        user.oauth_token = ENV["OAUTH_TOKEN"]
        user.username = "ksk5280"
        repos = service.repos(user)
        repo = repos.first

        expect(repo[:name]).to eq("active-record-sinatra")
        expect(repos.count).to eq(30)
      end
    end
  end
end
