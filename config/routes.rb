Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :items, only: [:index, :create, :update]
      post '/prices', to: 'items#price', only: [:price]
    end
  end
end
