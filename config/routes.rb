Rails.application.routes.draw do
  root 'homes#show'

  get "/:username", to: "users#show", as: "user"
  get "/following/:username", to: "users#following", as: "following"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"
end
