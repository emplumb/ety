Rails.application.routes.draw do

  #Terms routes
  root "terms#home"

  get "/about", to: "terms#about"

  get "/appendix", to: "terms#appendix"

  get "/phonology", to: "terms#phonology"

  get "/sources", to: "terms#sources"

  get "/contact", to: "terms#contact"

  get "/directory", to: "terms#directory"

  get "/directory/:letter", to: "terms#directory"

  get "/term/:id", to: "terms#show"

  get "/search", to: "terms#search"

  #Contact route
  post "/submit_message" => "contact#submit_message"

  #Errors routes
  match "/404", to: "errors#not_found", :via => :all

  match "/422", to: "errors#unacceptable", :via => :all

  match "/500", to: "errors#internal_server_error", :via => :all

end
