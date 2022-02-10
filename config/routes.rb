Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      resources :merchants, only: %i[index show] do
        resources :items, only: [:index], controller: :merchant_items
      end
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
  # Non- RESTful
end
