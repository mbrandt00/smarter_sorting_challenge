Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      resources :products, only: [:index, :create]
      get '/with_ingredient', to: 'products#with_ingredient'
    end
  end
end
