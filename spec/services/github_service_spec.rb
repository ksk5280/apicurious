require "rails_helper"

describe GithubService do
  context '.repositories' do
    it "returns current user repositories" do
      service = GithubService.new
      user = User.first
      repositories = service.repos(user)
    end
  end
end
