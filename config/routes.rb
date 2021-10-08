Rails.application.routes.draw do

  resources :home
  root 'home#top'

  post "post/:id/comment" => "post#comment"
  
  get "signup" => "user#new"
  post "user/create" => "user#create"
  get "user/:id" => "user#show"
  get "login" => "user#login_form"
  post "login" => "user#login"
  post "logout" => "user#logout"

  get "room/index" => "room#index"
  get "room/new" => "room#new"
  post "room/create" => "room#create"
  get "room/join" => "room#join_form"
  post "room/join" => "room#join"
  post "room/out" => "room#out"
  get "room/:id/comment_index" => "room#comment_index"
  get "room/:id/image_new/3" => "post#image_new3"
  get "room/:id/image_new/2" => "post#image_new2"
  get "room/:id/image_new" => "post#image_new"
  post "room/:id/image_create/3" => "post#image_create3"
  post "room/:id/image_create/2" => "post#image_create2"
  post "room/:id/image_create" => "post#image_create"
  get "room/:id" => "room#show"
  
  get "/how_to_use" => "home#how_to_use"
  get "/tos" => "home#tos"
  get "/privacyPolicy" => "home#privacyPolicy"
  get "/" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
