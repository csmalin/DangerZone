Dangerzone::Application.routes.draw do
  root to: "session#index"

  resources :crimes 
  match 'update' => 'crimes#update'
  match 'all'   => 'crimes#show'
end
