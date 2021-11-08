Rails.application.routes.draw do
  devise_for :users
  resources :maller
  resources :profiles, only: [:index,:show] do
    resources :relationships, only: [:create,:destroy]
  end


  get "/"=>'home#top'
  get "/about" => 'home#about'
  get "/contact" => 'maller#new'
  post 'maller/create', to: 'maller#create'

  get '/pages/index'
  get '/pages/show'

  get "profile/search"=>"profiles#search"


  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
