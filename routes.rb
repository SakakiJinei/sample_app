Rails.application.routes.draw do
  
  root 'home#top'
  get "/top" => "home#top"
  get "/about" => "home#about"
  get "/term" => "home#term" 
  
  get 'values/index' => "values#index"
  post 'values/:id/create' => "values#create"
  get 'values/:id/edit' => "values#edit"
  patch 'values/:id/update' => "values#update"
  post "values/:id/destroy" => "values#destroy"

  get "chats/index" => "chats#index"
  post 'chats/:post_id/create' => "chats#create"
  post 'chats/:id/destroy' => "chats#destroy"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"
  
  get 'login' => "users#login_form"
  post 'login' => "users#login"
  post 'logout' => "users#logout"
  
  get 'email' => "users#email"
  post 'submit' => "users#submit"
  get 'password/:id' => "users#password"
  post 'reset/:id' => "users#reset"
  get 'repassword' => "users#repassword"
  
  post 'users/:id/update' => "users#update"
  get 'users/:id/edit' => "users#edit"
  post 'users/:id/destroy' => "users#destroy"
  post 'users/create' => "users#create"
  get 'signup' => "users#new"
  get 'users/index' => "users#index"
  get 'users/:id' => "users#show"
  get 'users/:id/likes' => "users#likes"
  get 'users/:id/chat' => "users#chat"
  get 'users/:id/history' => "users#history"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"
  get "posts/:id/list" => "posts#list"
  
  get "posts/:id/buy" => "posts#buy"
  get "buys/new" => "buys#new"
  post "buys/:id/create" => "buys#create"
  get "buys/:id/show" => "buys#show"
  get "buys/:id/destroy" => "buys#destroy"
  get "buys/finish" 
  
  post "posts/pay" => "posts#pay"
  
  get "contacts/new" => "contacts#new"
  get "contacts/new" => "contacts#new"  
  post "contacts/create" => "contacts#create"

end
