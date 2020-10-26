Rails.application.routes.draw do

  get '/', to: 'Welcome#'
  get '/team', to:'team#introduce'
  get '/contact_us', to:'contact#contact_us'
  get '/welcome/:first_name', to:'welcome#first_name'

end
