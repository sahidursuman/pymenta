Pymenta::Application.routes.draw do

  resources :products do
    match "product_list_report", :on => :collection
  end

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :companies
    resources :brands
    resources :products
    resources :categories
    resources :clients
    resources :providers
    resources :warehouses
    resources :document_types
    resources :document_lines
    resources :documents
    resources :stocks
    resources :document_types
    resources :accounts
    resources :payments
    authenticated :user do
      root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users, :controllers => { :registrations => "registrations"}
    resources :users
    match '/:locale/products/search' => 'products#search', :as => :product_search
    match '/:locale/clients/search' => 'clients#search', :as => :client_search
    match '/:locale/providers/search' => 'providers#search', :as => :provider_search
    match '/:locale/companies/settings' => 'companies#settings', :as => :settings
  end  

end
