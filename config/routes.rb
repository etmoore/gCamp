Rails.application.routes.draw do

  root "pages#homepage"
  get "about" => "pages#about", as: :about
  get "terms" => "pages#terms", as: :terms

end
