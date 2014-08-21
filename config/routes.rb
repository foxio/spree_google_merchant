Spree::Core::Engine.routes.draw do
  get "google_merchant/:locale/feed" => 'google_merchant#index', :constraints => {:format => :rss}

  namespace :admin do
    resource :google_merchants
  end
end
