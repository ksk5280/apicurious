class GithubService
  def initialize
    @_connection = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def repos(user)
    parse(connection.get("/users/#{user.username}/repos", access_token(user)))
  end

  def orgs(user)
    parse(connection.get("/users/#{user.username}/orgs", access_token(user)))
  end

  def followers(user)
    parse(connection.get("/users/#{user.username}/followers", access_token(user)))
  end

  def following(user)
    parse(connection.get("/users/#{user.username}/following", access_token(user)))
  end

  def starred_repos(user)
    parse(connection.get("/users/#{user.username}/starred", access_token(user)))
  end

  def events(user)
    parse(connection.get("/users/#{user.username}/events", access_token(user)))
  end

  def followed_events(followed_username)
    parse(connection.get("/users/#{followed_username}/events", github_secrets))
  end

  private

    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true, object_class: OpenStruct)
    end

    def access_token(user)
      { "access_token" => user.oauth_token.to_s }
    end

    def github_secrets
      { "client_id" => ENV["GITHUB_KEY"], "client_secret" => ENV["GITHUB_SECRET"] }
    end
end
