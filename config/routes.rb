Hackchat::Application.routes.draw do
  resources :messages, :rooms
  root to: "rooms#index"
end
