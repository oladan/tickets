Rails.application.routes.draw do

  get 'replies/create'

  resources :tickets, :only => [:show, :new, :create, :index] do
    resources :replies
  end

  resources :states
  resources :departments

  devise_for :owners
  
  root to: "tickets#index"
end