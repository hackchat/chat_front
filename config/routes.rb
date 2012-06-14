Hackchat::Application.routes.draw do
  resources :messages, :rooms, :room_permissions, :roomies
  root to: "rooms#index"
end
