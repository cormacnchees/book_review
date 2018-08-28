Rails.application.routes.draw do
  devise_for :users
  resources :books

  #sets books as HomePage
  root 'books#index'
end
