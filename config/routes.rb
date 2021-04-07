Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'api/done_posts/:uid', to: "api/done_posts#create"

  namespace :api do
    resources :users
    resources :done_posts
  end
end
