Rails.application.routes.draw do
  # Routes for the Term resource:
  # resources :terms
  # READ
  root "terms#home"



  get "/directory", :controller => "terms", :action => "directory"
  get "directory/term/:name", :controller => "terms", :action => "show"
  # get "/term/:id", :controller => "terms", :action => "show"

  get "/directory/:letter", :controller => "terms", :action => "directory"



end
