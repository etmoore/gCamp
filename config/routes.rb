Rails.application.routes.draw do

  resources :tasks, :users

  root "homepage#show"
  get "about" => "about#show", as: :about
  get "terms" => "terms#show", as: :terms
  get "faq" => "faq#show", as: :faq

end
