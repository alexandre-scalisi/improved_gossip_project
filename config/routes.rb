Rails.application.routes.draw do
  resources :gossips
  resources :users
  resources :cities, only:[:show]
  resources :sessions, only:[:new, :create, :destroy]
  resources :comments, :path => "/gossips/:id1/comments"
  get '/', to: 'home#show'
  get '/team', to:'team#show'
  get '/contact', to:'contact#show'
  get '/welcome/:first_name', to:'welcome#show', as: :welcome
  get 'gossips/:id/like', to:'gossips#like'
  post 'gossips/:id/like', to:'gossips#like', as: :gossip_likes
end
