Rails.application.routes.draw do
  post "/signup", to: "auth#signup"
  post "/login", to: "auth#login"
  get "/issues/analytics", to: "issues#analytics"

  resources :issues, only: [:create, :index, :update] do
    resources :comments, only: [:create]
  end
end


