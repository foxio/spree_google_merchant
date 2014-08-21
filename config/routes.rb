Spree::Core::Engine.routes.append do
  resources :products do 
    get :google_merchant
  end

  namespace :admin do
    resource :google_merchants
  end
end
