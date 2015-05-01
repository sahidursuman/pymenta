Pymenta::Application.routes.draw do

  resources :products do
    get "product_list_report", :on => :collection
  end
    
 resources :payments_documents do
    get "payments_documents_report", :on => :collection
    get "retention_report", :on => :collection
  end

  resources :documents do
    get "documents_report", :on => :collection
    get "document_report", :on => :collection
  end

  resources :providers do
    get "providers_report", :on => :collection
    get "account_report", :on => :collection   
  end
  
  resources :clients do
    get "clients_report", :on => :collection
    get "account_report", :on => :collection   
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
    resources :guest

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
    match '/:locale/documents/search' => 'documents#search', :as => :documents_search
    match '/:locale/payments_documents/search' => 'payments_documents#search', :as => :payments_documents_search
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
    match '/:locale/documents/create_document_account' => 'documents#create_document_account', :as => :create_document_account   
    match '/:locale/payments_documents/add_payments_document_id' => 'payments_documents#add_payments_document_id', :as => :add_payments_document_id  
    match '/:locale/payments_documents/remove_payments_document_id' => 'payments_documents#remove_payments_document_id', :as => :remove_payments_document_id  
    match '/:locale/payments_documents/create_payment_line' => 'payments_documents#create_payment_line', :as => :create_payment_line
    match '/:locale/documents/new' => 'documents#new', :as => :new
    match '/:locale/payments_documents/new' => 'payments_documents#new', :as => :new
    match '/:locale/payments_documents/new_modal' => 'payments_documents#new_modal', :as => :new_modal
    match '/:locale/payments_documents/create_payments_document_account' => 'payments_documents#create_payments_document_account', :as => :create_payments_document_account   
    match '/:locale/companies/edit_formats' => 'companies#edit_formats', :as => :edit_formats 
    match '/:locale/companies/subscribe_month' => 'companies#subscribe_month', :as => :subscribe_month 
    match '/:locale/companies/subscribe_year' => 'companies#subscribe_year', :as => :subscribe_year 
    match '/:locale/companies/subscribe_alert' => 'companies#subscribe_alert', :as => :subscribe_alert 
#    match '/:locale/companies/became_free' => 'companies#became_free', :as => :became_free 
    match '/:locale/privacy' => 'privacy#index', :as => :privacy
    match '/:locale/terms' => 'terms#index', :as => :terms
    match '/:locale/guest/guest_list' => 'guest#guest_list', :as => :guest_list
  end  

end

