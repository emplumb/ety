Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/unacceptable'

  get 'errors/internal_server_error'

  root "terms#home"

  get "/about", :controller => "terms", :action => "about"

  get "/appendix", :controller => "terms", :action => "appendix"

  get "/phonology", :controller => "terms", :action => "phonology"

  get "/sources", :controller => "terms", :action => "sources"

  get "/contact", :controller => "terms", :action => "contact"

  get "/directory", :controller => "terms", :action => "directory"

  get "/directory/:letter", :controller => "terms", :action => "directory"

  get "/term/:id", :controller => "terms", :action => "show"

  get "search" => "terms#search"

  post "/submit_message", :controller => "contact", :action => "submit_message"

end
