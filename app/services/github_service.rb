class GithubService
  attr_reader :connection, :access_token

  def initialize
    @connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def repos(user)
    parse(@connection.get "/users/#{user.username}/repos", { 'access_token' => "#{user.oauth_token}" })
  end

  def followers(user)
    parse(@connection.get "/users/#{user.username}/followers", { 'access_token' => "#{user.oauth_token}" })
  end

  private

    def parse(response)
      JSON.parse(response.body, object_class: OpenStruct)
    end
end
