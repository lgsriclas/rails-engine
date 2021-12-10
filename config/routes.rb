Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      get 'merchants/find_all', to: 'merchants_search#index'
      get 'merchants/find', to: 'merchants_search#show'

      resources :merchants, only: [:index, :show] do
        resources :items, module:'merchants', only: [:index]
      end

      get 'items/find_all', to: 'items_search#index'
      get 'items/find', to: 'items_search#show'

      resources :items do
        resources :merchant, module: 'items', only: [:index]
      end
    end
  end
end
