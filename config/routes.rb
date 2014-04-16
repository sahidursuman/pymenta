Pymenta::Application.routes.draw do

  resources :accounts
  resources :products do
    match "product_list_report", :on => :collection
  end

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :companies
    resources :brands
    resources :products
    resources :categories
    authenticated :user do
      root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users, :controllers => { :registrations => "registrations"}
    resources :users
    match '/:locale/products/search' => 'products#search', :as => :product_search
  end  

end
