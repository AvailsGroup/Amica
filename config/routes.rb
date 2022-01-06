Rails.application.routes.draw do
  #devise--------------
  get 'users/controller'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    patch 'users/confirm' => 'users/confirmations#confirm'
  end

  # top----------------
  get '/' => 'home#top'
  get '/about' => 'home#about'
  get '/contact' => 'mailer#new'
  get '/static' => 'home#static'
  get '/privacy' => 'home#privacy'
  get '/help_page' => 'home#help_page'
  post 'mailer/create', to: 'mailer#create'

  # communities---------
  resources :communities do
    resources :manage, only: %i[create destroy]
    resources :communities_security, only: %i[create destroy]
    resources :reports, only: [:create]
    get :members
    delete :kick
    put :change
    get :banned_member
    collection do
      get :pickup
      get :joined
    end
    resources :communities_room, only: %i[show]
  end


  # timelines-----------
  resources :timelines do
    resources :likes, only: %i[create destroy]
    resources :comments, only: %i[create destroy]
    resources :reports, only: [:create]
    resources :mute, only: %i[create destroy]
    collection do
      get :search
      get :follow
      get :pickup
      get :latest
    end
  end

  # pages---------------
  resources :pages, only: [:index] do
    post 'favorite/user_create' => 'favorite#user_create'
    delete 'favorite/community_delete' => 'favorite#community_destroy'
    post 'favorite/community_create' => 'favorite#community_create'
    delete 'favorite/user_delete' => 'favorite#user_destroy'
    collection do
      get :tutorial
    end
  end
  post 'page/user' => 'pages#user'
  post 'page/community' => 'pages#community'
  get 'setting' => 'pages#setting'
  get 'faq' => 'pages#faq'


  resources :settings, only: %i[index] do
    collection do
      post :enable_enrolled_year
      delete :disable_enrolled_year
    end
  end

  # profiles------------
  resources :profiles do
    resources :relationships, only: %i[create destroy]
    resources :block, only: %i[create destroy]
    get :follow
    get :follower
    collection do
      get :friends
      get :pickup
    end
  end

  # chats--------------
  resources :chats

  # searches-----------
  resources :searches, only: [:index] do
    get '/tag' => 'searches#tag'
  end
  post 'search/user' => 'searches#user'
  post 'search/community' => 'searches#community'

  # notification--------
  resources :notifications, only: %i[index destroy]
  resources :informations, only: %i[index show]
  resources :whispers, only: %i[index show]

  # ranking------------
  resources :ranking, only: %i[index] do
    collection do
      get :post
      get :comment
      get :follow
      get :follower
      get :friend
      get :community
      get :member
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
