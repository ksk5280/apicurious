require "rails_helper"

RSpec.feature "Visitor can view homepage" do
  scenario "sees login button" do
     visit "/"
     expect(page).to have_content "Sign in with Github"
  end
end
