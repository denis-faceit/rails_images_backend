Rails.application.routes.draw do
  namespace :api do
    post 'authenticate', to: 'authentication#authenticate'
    get 'images/', to: 'archives#index'
    post 'images/', to: 'archives#search'
    get 'images/:token', to: 'archives#show'
    post 'upload/', to: 'archives#create'
  end
end
