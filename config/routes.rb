Rails.application.routes.draw do

  root 'welcome#home'
  get "about", to:'welcome#about'
  get "signup", to:'users#new'
  # post "signup", to: 'users#create'
  
  get "login", to: 'sessions#new'
  post "login", to: 'sessions#create'
  delete "logout", to: 'sessions#destroy'

  resources :articles
  resources :users, except: :new
  resources :categories

end
