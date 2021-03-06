Hackchat::Application.routes.draw do
  resource :uploader
  resources :messages
  resources :rooms do
    resources :permissions
  end
  resources :roomies
  root to: "rooms#index"
  resources :searches, only: [:create]
end
