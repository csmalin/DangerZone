Dangerzone::Application.routes.draw do
 
  resources :crimes 
  match 'update' => 'crimes#update'
  match 'search' => 'crimes#search'
  match 'results' => 'crimes#results'
  root to: "session#index"

end
