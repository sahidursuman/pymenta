Pymenta::Application.routes.draw do

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
    match '/products/search' => 'products#search', :as => :product_search
  end  

end
