Rails.application.routes.draw do

  get 'user/info'
  get 'gossips/names'
  get '/', to: 'accueil#show', as: 'home'
  get '/team', to:'team#introduce'
  get '/contact_us', to:'contact#contact_us'
  get '/welcome/:first_name', to:'welcome#first_name'
  get '/gossips/:name', to:"gossips#names" ,as: 'gossip_names'
  get '/users/:name', to: "user#info", as: 'user_name'
end
