Rails.application.routes.draw do
  get '/sign_up' => 'registrations#new'
  post '/sign_up' => 'registrations#create'

  get '/sign_in' => 'sessions#new'
  post '/sign_in' => 'sessions#create'

  delete '/sign_out' => 'sessions#destroy'

  resource :dashboard, only: :show
  resources :rewards
  resources :users, only: [] do
    resources :points, only: [:index, :create]
  end
  resources :rewards, only: [] do 
    resources :redemptions, only: [:index, :create]
  end
  root to: 'dashboards#show'
end
