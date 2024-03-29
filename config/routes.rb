Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/most_items', to: 'items#index'
      end
      resources :merchants, only: %i[index show] do
        resources :items, only: %i[index show], controller: :merchant_items
      end
      resources :revenue, only: :index
    end
  end
  namespace :api do
    namespace :v1 do
      namespace :items do
        get '/find_all', to: 'search#index'
      end
      resources :items do
        resources :merchant, only: :index, controller: :items_merchant
      end
    end
  end
end
