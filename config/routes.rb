Rails.application.routes.draw do
  root 'sessions#new'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: :logout
  patch '/bills/:id/update_status', to: 'bills#update_status', as: :update_status_bill

  resources :users, only: [:index, :new, :create, :edit, :update, :destroy]

  resources :bills, only: [:index, :new, :create, :update] do
    collection do
      get :admin_index, path: "admin"
    end
  end
end
