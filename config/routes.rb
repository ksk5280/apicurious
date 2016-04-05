Rails.application.routes.draw do
  root 'homes#show'

  get "/:username", to: "users#show", as: "user_show"

  get "/auth/github", as: :github_login
  get "/auth/github/callback", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"
end
