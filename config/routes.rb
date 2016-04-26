Rails.application.routes.draw do
  # Routes for the Term resource
  # resources :terms

  # READ
  root "terms#home"

  get "/about", :controller => "terms", :action => "about"

  get "/faq", :controller => "terms", :action => "faq"

  get "/contact", :controller => "terms", :action => "contact"

  get "/directory", :controller => "terms", :action => "directory"

  get "/directory/:letter", :controller => "terms", :action => "directory"

  get "/term/:name", :controller => "terms", :action => "show"

  # get "/terms/search", :controller => "terms", :action => "search"
  # turns into:
  get "search" => "terms#search"

  post "/submit_message", :controller => "contact", :action => "submit_message"

  get "/email_confirmation", :controller => "contact", :action => "email_confirmation"


  #revisit below
  # get "/directory/search", :controller => "terms", :action => "search"

  # get "/directory/search", to: "directory#search", as: "search"

end
