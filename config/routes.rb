Hackchat::Application.routes.draw do
  resources :messages, :rooms, :permissions, :roomies
  root to: "rooms#index"
end
