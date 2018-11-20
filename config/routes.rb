Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #root url
  root to: 'categories#index'
  
  #custom urls
  get '/categories/:id', to: 'categories#show'
  post '/save_photo', to: 'photos#create'
  delete '/destroy_photo/:id', to: 'photos#destroy', :as => 'destroy_photo'

  #swagger url
  mount GrapeSwaggerRails::Engine => '/swagger' 
  mount API => '/'
end
