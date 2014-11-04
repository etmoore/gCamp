Rails.application.routes.draw do

  resources :tasks, :users, :projects

  root "homepage#show"
  get "about" => "about#show", as: :about
  get "terms" => "terms#show", as: :terms
  get "faq" => "faq#show", as: :faq
  get '/sign-up' => 'registrations#new', as: :signup
  post '/sign-up' => 'registrations#create'
  get '/sign-in' => 'authentication#new', as: :signin
  post '/sign-in' => 'authentication#create'
  get '/sign-out' => 'authentication#destroy', as: :signout

end
