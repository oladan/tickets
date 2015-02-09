Rails.application.routes.draw do

  get 'replies/create'

  resources :tickets, :only => [:show, :new, :create, :index] do
    resources :replies
  end
  
  resources :states, :only => [:show, :new, :create, :index, :update, :edit]
  resources :departments, :only => [:show, :new, :create, :index, :update, :edit]

  devise_for :owners

  resources :owners, :only => [:show]
  
  root to: "tickets#index"
end