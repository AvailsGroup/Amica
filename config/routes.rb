Rails.application.routes.draw do

  get 'users/controller'

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :confirmations => 'users/confirmations',
  }

  devise_scope :user do
    patch 'users/confirm' => 'users/confirmations#confirm'
  end

  resources :maller
  resources :pages

  get 'users/setting' => 'pages#setting'

  resources :communities
  resources :searches
  resources :chats

  resources :timelines do
    resources :likes,only:[:create,:destroy]
    collection do
      get :search
    end
  end

  resources :profiles do
    resources :relationships, only: [:create,:destroy]
  end
  get 'profile/search'=>'profiles#search'
  get 'profile/follow' => 'profiles#follow'
  get 'profile/follower' => 'profiles#follower'
  get 'profile/friends' => 'profiles#friends'



  get '/'=>'home#top'
  get '/about' => 'home#about'
  get '/contact' => 'maller#new'
  get '/static' => 'home#static'
  get '/privacy' => 'home#privacy'
  post 'maller/create', to: 'maller#create'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
