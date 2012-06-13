Hackchat::Application.routes.draw do
  resources :messages, :rooms, :room_permissions
  root to: "rooms#index"
end
