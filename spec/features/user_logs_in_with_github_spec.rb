require "rails_helper"
require "helpers/authentication"

RSpec.feature "User logs in with Github and logs out" do
  include Authentication
  before(:each) do
    Capybara.app = Apicurious::Application
    stub_omniauth
  end

  scenario "sees home page" do
    VCR.use_cassette("sessions") do
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
  end
end
