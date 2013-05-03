Dangerzone::Application.routes.draw do

  root to: "session#index"

  resources :crimes 
  match 'update' => 'crimes#update'

  match 'all'   => 'crimes#show'

  match 'search' => 'crimes#search'

  match 'results' => 'crimes#results'
  
end
