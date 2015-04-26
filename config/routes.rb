Rails.application.routes.draw do
  get '/sign_up' => 'registrations#new'
  post '/sign_up' => 'registrations#create'

  get '/sign_in' => 'sessions#new'
  post '/sign_in' => 'sessions#create'

  delete '/sign_out' => 'sessions#destroy'
  root to: 'application#show'
end
