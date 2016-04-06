class GithubService
  def initialize
    @_connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def access_token(user)
    { 'access_token' => "#{user.oauth_token}" }
  end

  def repos(user)
    parse(connection.get "/users/#{user.username}/repos", access_token(user))
  end

  def orgs(user)
    parse(connection.get "/users/#{user.username}/orgs", access_token(user))
  end

  def followers(user)
    parse(connection.get "/users/#{user.username}/followers", access_token(user))
  end

  def following(user)
    parse(connection.get "/users/#{user.username}/following", access_token(user))
  end

  def starred_repos(user)
    parse(connection.get "/users/#{user.username}/starred", access_token(user))
  end

  def events(user)
    parse(connection.get "/users/#{user.username}/events", access_token(user))
    # parse(connection.get "/users/#{user.username}/events", access_token(user))[4][:type]
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true, object_class: OpenStruct)
    end

    def connection
      @_connection
    end
end
