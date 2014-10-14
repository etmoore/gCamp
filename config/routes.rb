Rails.application.routes.draw do

  root "homepage#show"
  get "about" => "about#show", as: :about
  get "terms" => "terms#show", as: :terms

end
