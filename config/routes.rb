Rails.application.routes.draw do

  resources :home
  root 'home#top'

  post "post/:id/note_comment_create/:id" => "post#note_comment_create"
  
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
  get "room/:id/note_index" => "room#note_index"
  get "room/:id/new_note" => "room#new_note"
  post "images" => "room#note_create"
  get "room/:id/note_comment/:id" => "room#note_comment"
  
  get "/how_to_use" => "home#how_to_use"
  get "/tos" => "home#tos"
  get "/privacyPolicy" => "home#privacyPolicy"
  get "/" => "home#top"

  resources :images
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
