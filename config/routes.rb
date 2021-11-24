Rails.application.routes.draw do

  get 'users/controller'

  devise_for :users, controllers: {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
  }

  resources :maller
  resources :pages
  resources :homes
  resources :communities
  resources :searches

  resources :chats
  resources :mypages

  resources :timelines do
    resources :likes,only:[:create,:destroy]
  end
  resources :profiles, only: [:index,:show] do
    resources :relationships, only: [:create,:destroy]
  end

  get "profile/search"=>"profiles#search"
  get "profile/follow" => "profiles#follow"
  get "profile/follower" => "profiles#follower"
  get "profile/friends" => "profiles#friends"

  get "/"=>'home#top'
  get "/about" => 'home#about'
  get "/contact" => 'maller#new'
  post 'maller/create', to: 'maller#create'
  get 'pages/index'
  get 'pages/show'
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
