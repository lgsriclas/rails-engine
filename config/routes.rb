Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get 'most_items', to: 'merchants#index'
        # resources :most_items, only: :index
      end

      get 'merchants/find_all', to: 'merchants_search#index'
      get 'merchants/find', to: 'merchants_search#show'

      resources :merchants, only: [:index, :show] do
        resources :items, module:'merchants', only: [:index]
        # get 'items', to: 'merchants/items#index'
      end

      get 'items/find_all', to: 'items_search#index'
      get 'items/find', to: 'items_search#show'

      resources :items do
        resources :merchant, module: 'items', only: [:index]
        # get 'merchants', to: 'items/merchants#show'
      end

      namespace :revenue do
        # resources :merchants, only: [:index, :show]
        # resources :items, only: [:index, :show]
        get 'merchants', to: 'merchants#index'
        get 'merchants/:id', to: 'merchant#show'
        get 'items', to: 'items#index'
      end
    end
  end
end
