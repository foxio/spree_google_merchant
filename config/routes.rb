Spree::Core::Engine.routes.draw do
  match "google_merchant/:locale/feed" => 'google_merchant#index', :constraints => {:format => :rss}

  namespace :admin do
    resource :google_merchants
  end
end
