Dataplay::Application.routes.draw do
  resources :companies

  resources :filings

  root :to => "home#index"
  resources :users, :only => [:index, :show, :edit, :update ]
  
  get '/importer' => "filings#importer"
  get '/backlog' => 'filings#backlog'

  get '/processor' => 'filings#processor'


  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'


  get '/api' => 'api#index'
  get '/api/company' => 'api#company'
  get '/api/filing' => 'api#filing'
  
end
