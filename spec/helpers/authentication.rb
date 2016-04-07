module Authentication
  def stub_omniauth
    # set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: "1234",
      info: {
        name: "Kimiko",
        nickname: "ksk5280",
        image: "image"
      },
      credentials: {
        token: ENV["OAUTH_TOKEN"]
      }
    })
  end
end
