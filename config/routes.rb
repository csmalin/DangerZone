Dangerzone::Application.routes.draw do
<<<<<<< HEAD

  root to: "session#index"

  resources :crimes 
  match 'update' => 'crimes#update'

  match 'all'   => 'crimes#show'

  match 'search' => 'crimes#search'

  match 'results' => 'crimes#results'
  
=======
 
  resources :crimes 
  match 'update' => 'crimes#update'
  match 'search' => 'crimes#search'
  match 'results' => 'crimes#results'
  root to: "session#index"

>>>>>>> master
end
