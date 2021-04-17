Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'api/done_posts/:uid', to: "api/done_posts#create"
  post 'api/users/:uid', to: "api/users#update"
  get 'api/users/:uid', to: "api/users#show"
  get 'api/users/:uid/feed', to: "api/users#showFeed"
  get 'api/users/following/:uid', to: "api/users#following"
  get 'api/relationships/', to: "api/relationships#create"
  delete 'api/likes/', to: "api/likes#destroy"

  namespace :api do
    resources :users
    resources :done_posts 
    resources :relationships, only: [:destroy]
    resources :likes, only: [:create, :destroy]
  end
end
