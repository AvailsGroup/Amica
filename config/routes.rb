Rails.application.routes.draw do


  get 'users/controller'
  devise_for :users


  resources :maller
  resources :pages
  resources :homes
  resources :communities
  resources :searches
  resources :timelines
  resources :chats
  resources :mypages
  post 'mypages/update', to: 'mypages#update'



  get "/"=>'home#top'
  get "/about" => 'home#about'
  get "/contact" => 'maller#new'
  post 'maller/create', to: 'maller#create'


  get 'pages/index'
  get 'pages/show'
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
