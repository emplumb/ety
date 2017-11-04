Rails.application.routes.draw do

  #Terms routes
  root "terms#home"

  get "/sources", to: "terms#sources"
  get "/appendix", to: "terms#appendix"
  get "/contact", to: "terms#contact"
  get "/directory", to: "terms#directory"
  get "/term", to: "terms#directory"
  get "/directory/:letter", to: "terms#directory"
  get "/search", to: "terms#search"

  get "/term/:id", to: "terms#show"
  get "/term/:id/edit", to: "terms#edit"
  patch "/term/:id", to: "terms#update"

  #Static Pages routes
  get "/about", to: "static_pages#about"
  get "/phonology", to: "static_pages#phonology"

  #Contact route
  post "/submit_message", to: "contact#submit_message"

  #Errors routes
  match "/404", to: "errors#not_found", :via => :all
  match "/422", to: "errors#unacceptable", :via => :all
  match "/500", to: "errors#internal_server_error", :via => :all

  #Sessions routes
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"




end
