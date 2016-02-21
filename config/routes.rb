Rails.application.routes.draw do

  root "homepage#show"

  resources :users

  resources :projects do
    resources :tasks
    resources :memberships
  end

  resources :comments, only: :create

  resources :tracker_projects, only: [:show]

  # static page routes
  get "about" => "about#show", as: :about
  get "terms" => "terms#show", as: :terms
  get "faq" => "faq#show", as: :faq

  # registration routes
  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'

  # authentication routes
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

end
