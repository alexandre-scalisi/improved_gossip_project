Rails.application.routes.draw do
  resources :gossips
  resources :users, only:[:show]
  resources :cities, only:[:show]
  resources :comments, :path => "/gossips/:id1/comments"
  get '/', to: 'home#show'
  get '/team', to:'team#show'
  get '/contact', to:'contact#show'
  get '/welcome/:first_name', to:'welcome#show'
end
