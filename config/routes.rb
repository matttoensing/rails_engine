Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :items do
        resources :find, only: [:index], controller: :search
      end

      namespace :merchants do
        resources :find_all, only: [:index], controller: :search
      end

      namespace :revenue do
        resources :merchants, only: %i[index show]
        resources :weekly, only: [:index]
        resources :unshipped, only: :index
      end

      resources :merchants, only: %i[index show]
      resources :items, except: %i[new edit]

      get '/merchants/:merchant_id/items', to: 'merchant_items#index'
      get '/items/:item_id/merchant', to: 'items_merchant#show'
    end
  end
end
