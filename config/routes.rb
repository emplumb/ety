Rails.application.routes.draw do
  # Routes for the Term resource
  # resources :terms

  # READ
  root "terms#home"

  get "/about", :controller => "terms", :action => "about"

  get "/contact", :controller => "terms", :action => "contact"

  get "/directory", :controller => "terms", :action => "directory"

  get "/directory/:letter", :controller => "terms", :action => "directory"

<<<<<<< HEAD
  get 'search' => 'terms#search'
=======
  get "/directory/:name", :controller => "terms", :action => "show"
  # get "/directory/:id", :controller => "terms", :action => "show"

>>>>>>> es-setup

  # get "/directory/search", :controller => "terms", :action => "search"


  # get "/terms/search", :controller => "terms", :action => "search"
  # turns into:
  get 'search' => 'terms#search'
  #revisit below
  # get 'directory/search', to: 'directory#search', as: 'directory_search'

  get "/about", :controller => "terms", :action => "about"

  get "/contact", :controller => "terms", :action => "contact"

end
