Dangerzone::Application.routes.draw do
  root to: "session#index"

  resources :geocoder, :only => [:index]

  resources :crimes, :only => [:index, :show]

  match 'all'   => 'crimes#show'
end
