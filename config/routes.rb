Hackchat::Application.routes.draw do
  resources :messages, :rooms
  root to: "pages#index"
end
