Rails.application.routes.draw do
  root 'homepage#index'
  namespace :api do
    namespace :v1 do
      resources :customers
      resources :items
      resources :orders
      resources :line_items
      resources :group_items
      resources :promotion_line_items
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
