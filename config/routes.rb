Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index, :show] do
        resources :items, module:'merchants', only: [:index]
      end

      get 'items/find_all', to: 'items_search#index', controller: 'search'

      resources :items do
        resources :merchant, module: 'items', only: [:index]
      end

      # get '/items/find_all_items', to: 'items/items_search#find_all_item'
    end
  end
end
