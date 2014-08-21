Spree::Core::Engine.routes.append do
  get '/google_merchant', to: 'products#google_merchant'

  resources :products do
    get :google_merchant
  end

  namespace :admin do
    resource :google_merchants
  end
end
