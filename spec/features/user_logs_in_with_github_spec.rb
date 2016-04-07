require "rails_helper"

RSpec.feature "User logs in with Github and logs out" do
  include Capybara::DSL
  before(:each) do
    Capybara.app = Apicurious::Application
    stub_omniauth
  end

  scenario "sees home page" do
    visit "/"
    expect(page.status_code).to eq 200

    # logs in
    click_link "Sign in with Github"
    expect(current_path).to eq "/ksk5280"
    expect(page).to have_content "Kimiko"
    expect(page).to_not have_link "Sign in with Github"

    # logs out
    within ".dropdown-menu" do
      click_link "Sign out"
    end
    expect(current_path).to eq "/"
    expect(page).to_not have_content "Kimiko"
    expect(page).to have_content "Sign in with Github"
  end

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
