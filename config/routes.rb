Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'api/done_posts/:uid', to: "api/done_posts#create"
  get 'api/users/feed_by_hub', to: "api/users#showFeedBySelectedHub"
  post 'api/users/:uid', to: "api/users#update"
  get 'api/users/search', to: "api/users#search"
  get 'api/users/:uid', to: "api/users#show"
  get 'api/usersShow', to: "api/users#showUser"
  get 'api/users/:uid/feed', to: "api/users#showFeed"
  get 'api/users/:uid/feed_by_hub', to: "api/users#showFeedByHub"
  get 'api/users/:uid/hubs', to: "api/users#updateHub"
  get 'api/users/following/:uid', to: "api/users#following"
  get 'api/relationships/', to: "api/relationships#create"
  get 'api/blocks/', to: "api/blocks#create"
  get 'api/latest_users/', to: "api/users#latestUsers"
  delete 'api/likes/', to: "api/likes#destroy"

  namespace :api do
    resources :users
    resources :done_posts 
    resources :relationships, only: [:destroy]
    resources :blocks, only: [:destroy]
    resources :likes, only: [:create, :destroy]
    resources :replys, only: [:create, :destroy]
    resources :notifications, only: :index
  end
end
