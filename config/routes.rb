Dangerzone::Application.routes.draw do


  root to: "session#index"
  resources :geocoder

  resources :crimes

  match 'all'   => 'crimes#show'


end
