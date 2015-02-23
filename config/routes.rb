Pymenta::Application.routes.draw do

  resources :products do
    match "product_list_report", :on => :collection
  end
  
  resources :documents do
    get "document_report", :on => :collection
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
    resources :payments_documents

    authenticated :user do
      root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users, :controllers => { :registrations => "registrations"}
    devise_for :users 
    resources :users
    match '/:locale/products/search' => 'products#search', :as => :product_search
    match '/:locale/clients/search' => 'clients#search', :as => :client_search
    match '/:locale/providers/search' => 'providers#search', :as => :provider_search
    match '/:locale/companies/settings' => 'companies#settings', :as => :settings
    match '/:locale/products/autocomplete' => 'products#autocomplete', :as => :product_autocomplete
    match '/:locale/products/get_info_product' => 'products#get_info_from_selected_product', :as => :get_info_product
    match '/:locale/clients/autocomplete' => 'clients#autocomplete', :as => :client_autocomplete
    match '/:locale/clients/get_info_account' => 'clients#get_info_from_selected_account', :as => :get_info_client
    match '/:locale/providers/autocomplete' => 'providers#autocomplete', :as => :provider_autocomplete
    match '/:locale/providers/get_info_account' => 'providers#get_info_from_selected_account', :as => :get_info_provider
    match '/:locale/warehouses/autocomplete' => 'warehouses#autocomplete', :as => :warehouse_autocomplete
    match '/:locale/warehouses/get_info_account' => 'warehouses#get_info_from_selected_account', :as => :get_info_warehouse            
    match '/:locale/documents/remove_document_line' => 'documents#remove_document_line', :as => :document_remove_document_line
    match '/:locale/documents/create_document_line' => 'documents#create_document_line', :as => :create_document_line
    match '/:locale/documents/create_payment_line' => 'documents#create_payment_line', :as => :create_payment_line
    match '/:locale/documents/create_document_account' => 'documents#create_document_account', :as => :create_document_account   
    match '/:locale/documents/new' => 'documents#new', :as => :new
    match '/:locale/payments_documents/new' => 'payments_documents#new', :as => :new
    match '/:locale/payments_documents/create_payments_document_account' => 'payments_documents#create_payments_document_account', :as => :create_payments_document_account   
  end  

end
