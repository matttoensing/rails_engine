Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :search, only: [:index]
      end

      resources :merchants, only: [:index, :show]
      resources :items, except: [:new, :edit]
      
      get "/merchants/:merchant_id/items", to: 'merchant_items#index'
      get "/items/:item_id/merchant", to: 'items_merchant#show'
    end
  end
end
