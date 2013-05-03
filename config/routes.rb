Dangerzone::Application.routes.draw do
  get "session/home"

  root to: "session#index"
end
