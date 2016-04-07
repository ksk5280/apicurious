Rails.application.routes.draw do
  root 'homes#show'

  get "/:username", to: "users#show", as: "user"
  get "/:username/followers", to: "users#followers", as: "user_followers"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"
end
