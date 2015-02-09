Rails.application.routes.draw do

  resources :tickets, except: [:update, :destroy] do
    resources :replies
  end
  
  resources :states, except: [:destroy]
  resources :departments, except: [:destroy]

  devise_for :owners

  resources :owners, only: [:show]
  
  root to: "tickets#index"
end