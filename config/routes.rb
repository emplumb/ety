Rails.application.routes.draw do

  #Home Updates routes
  root "home_updates#home"
  get "/home/update/new", to: "home_updates#new"
  post "/home/update", to: "home_updates#create"
  get "/home/update/:id/edit", to: "home_updates#edit"
  patch "/home/update/:id", to: "home_updates#update"
  delete "/home/update/:id", to: "home_updates#destroy"

  #Terms routes
  get "/appendix", to: "terms#appendix"
  get "/directory", to: "terms#directory"
  get "/term", to: "terms#directory"
  get "/directory/:letter", to: "terms#directory"
  get "/search", to: "terms#search"

  get "/term/new", to: "terms#new"
  post "/term", to: "terms#create"
  get "/term/:id", to: "terms#show"
  get "/term/:id/edit", to: "terms#edit"
  patch "/term/:id", to: "terms#update"
  delete "/term/:id", to: "terms#destroy"

  #Sources routes
  get "/sources", to: "sources#index"
  get "/source/new", to: "sources#new"
  post "/sources", to: "sources#create"
  get "/source/:id/edit", to: "sources#edit"
  patch "/source/:id", to: "sources#update"
  delete "/source/:id", to: "sources#destroy"

  #About Page routes
  get "/about", to: "about_pages#show"
  get "/about/:id/edit", to: "about_pages#edit"
  patch "/about/:id", to: "about_pages#update"

  #Phonology Page routes
  get "/phonology", to: "phonology_pages#show"
  get "/phonology/:id/edit", to: "phonology_pages#edit"
  patch "/phonology/:id", to: "phonology_pages#update"

  #Contact Forms routes
  get "/contact", to: "contact_requests#new"
  post "/submit_message", to: "contact_requests#submit_message"

  #Errors routes
  match "/404", to: "errors#not_found", :via => :all
  match "/422", to: "errors#unacceptable", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all

  #Sessions routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"




end
