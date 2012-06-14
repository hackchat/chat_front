Hackchat::Application.routes.draw do
  resources :messages
  resources :rooms do
    resources :permissions
  end
  resources :roomies
  root to: "rooms#index"
end
