Rails.application.routes.draw do
  resources :gossips do
    resources :comments
  end
  resources :users
  resources :cities, only:[:show]
  resources :sessions, only:[:new, :create, :destroy] 
  
  root to:'gossips#index', as: 'home'
  get '/team', to:'team#show'
  get '/contact', to:'contact#show'
  get '/welcome/:first_name', to:'welcome#show', as: :welcome
  get 'gossips/:id/like', to:'gossips#like'
  post 'gossips/:id/like', to:'gossips#like', as: :gossip_likes
end
