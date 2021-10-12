Rails.application.routes.draw do
  get 'test/mail'
  devise_for :users
  get "/"=>'home#top'
  get "/about" => 'home#about'
  get "/contact" => 'home#contact'
  post '/test/mail', to: 'test#mail'

  get 'pages/index'
  get 'pages/show'
  mount LetterOpenerWeb::Engine, at: '/letter_opener'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
