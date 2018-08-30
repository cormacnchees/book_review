Rails.application.routes.draw do
  devise_for :users
  resources :books do
    resources :reviews
  end
  #sets books as HomePage
  root 'books#index'
end
