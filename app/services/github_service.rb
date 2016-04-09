require "open-uri"

class GithubService
  def initialize
    @_connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    @_connection.get do |req|
      req.params['access_token'] = user.oauth_token.to_s
    end
  end

  def repos(user)
    parse(connection.get("/users/#{username}/repos"))
    # parse(connection.get("/users/#{user.username}/repos", access_token(user)))
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

  def contribution_elements(user)
    page_doc(user).css(".contrib-number")
  end

  def contributions_in_last_year(user)
    contribution_elements(user)[0].children[0].to_s
  end

  def longest_streak(user)
    contribution_elements(user)[1].children[0].to_s
  end

  def current_streak(user)
    contribution_elements(user)[2].children[0].to_s
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

    def page_doc(user)
      html = open("https://github.com/#{user.username}")
      Nokogiri::HTML(html)
    end
end
