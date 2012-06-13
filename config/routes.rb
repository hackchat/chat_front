Hackchat::Application.routes.draw do
  resources :messages, :rooms, :permissions
  root to: "rooms#index"
end
