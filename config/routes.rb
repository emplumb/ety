Rails.application.routes.draw do

  root "terms#home"

  get "/about", :controller => "terms", :action => "about"

  get "/faq", :controller => "terms", :action => "faq"

  get "/contact", :controller => "terms", :action => "contact"

  get "/directory", :controller => "terms", :action => "directory"

  get "/directory/:letter", :controller => "terms", :action => "directory"

  get "/term/:name", :controller => "terms", :action => "show"

  get "search" => "terms#search"

  post "/submit_message", :controller => "contact", :action => "submit_message"

  # get "/email_confirmation", :controller => "contact", :action => "email_confirmation"

end
