Hackchat::Application.routes.draw do
  resources :messages
  resources :rooms do
    resources :permissions
  end
  root to: "rooms#index"
end
