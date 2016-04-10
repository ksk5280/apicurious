require "open-uri"

class GithubService
  def initialize(user)
    @_connection = Faraday.new(url: "https://api.github.com") do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.response :logger                  # log requests to STDOUT
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end

    @_connection.get do |req|
      req.params['access_token'] = user.oauth_token.to_s
    end

    @_user = user
  end

  def repos
    parse(connection.get("/users/#{user.username}/repos"))
  end

  def orgs
    parse(connection.get("/users/#{user.username}/orgs"))
  end

  def followers
    parse(connection.get("/users/#{user.username}/followers"))
  end

  def following
    parse(connection.get("/users/#{user.username}/following"))
  end

  def starred_repos
    parse(connection.get("/users/#{user.username}/starred"))
  end

  def events
    parse(connection.get("/users/#{user.username}/events"))
  end

  def followed_events(followed_username)
    parse(connection.get("/users/#{followed_username}/events", github_secrets))
  end

  def contribution_elements
    page_doc.css(".contrib-number")
  end

  def contributions_in_last_year
    contribution_elements[0].children[0].to_s
  end

  def longest_streak
    contribution_elements[1].children[0].to_s
  end

  def current_streak
    contribution_elements[2].children[0].to_s
  end

  private

    def user
      @_user
    end

    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true, object_class: OpenStruct)
    end

    def access_token
      { "access_token" => user.oauth_token.to_s }
    end

    def github_secrets
      { "client_id" => ENV["GITHUB_KEY"], "client_secret" => ENV["GITHUB_SECRET"] }
    end

    def page_doc
      html = open("https://github.com/#{user.username}")
      Nokogiri::HTML(html)
    end
end
