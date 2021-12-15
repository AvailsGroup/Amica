Rails.application.routes.draw do
  #devise--------------
  get 'users/controller'

  devise_for :users, controllers: {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :confirmations => 'users/confirmations',
  }

  devise_scope :user do
    patch 'users/confirm' => 'users/confirmations#confirm'
  end

  #top----------------
  get '/'=>'home#top'
  get '/about' => 'home#about'
  get '/contact' => 'maller#new'
  get '/static' => 'home#static'
  get '/privacy' => 'home#privacy'
  get '/help_page' => 'home#help_page'
  post 'maller/create', to: 'maller#create'

  resources :maller

  #communities---------
  resources :communities do
    resources :manage, only: [:create, :destroy]
    get '/members' => 'communities#members'
    collection do
      get :pickup
      get :joined
    end
  end


  #timelines-----------
  resources :timelines do
    resources :likes,only:[:create,:destroy]
    resources :comments, only: [:create, :destroy]
    collection do
      get :search
      get :follow
      get :pickup
      get :latest
    end
  end


  #pages---------------
  resources :pages, only:[:index] do
    post 'favorite/user_create' => 'favorite#user_create'
    delete 'favorite/community_delete' => 'favorite#community_destroy'
    post 'favorite/community_create' => 'favorite#community_create'
    delete 'favorite/user_delete' => 'favorite#user_destroy'
  end
  post 'page/user'=>'pages#user'
  post 'page/community'=>'pages#community'
  get 'setting' => 'pages#setting'
  get 'faq' => 'pages#faq'

  #profiles------------
  resources :profiles do
    resources :relationships, only: [:create,:destroy]
    resources :achievements, only: [:update]
    collection do
      get :follow
      get :follower
      get :friends
      get :pickup
    end
  end

  #chats--------------
  resources :chats

  #searches-----------
  resources :searches, only: [:index] do
    get '/tag' => 'searches#tag'
  end
  post 'search/user' => 'searches#user'
  post 'search/community' => 'searches#community'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
