Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  
  resources :providers do
    get "providers_report", :on => :collection
    get "account_report", :on => :collection   
  end
  
  resources :products do
    get "product_list_report", :on => :collection
  end
  
  resources :clients do
    get "clients_report", :on => :collection
    get "account_report", :on => :collection   
  end
  
  resources :documents do
    get "documents_report", :on => :collection
    get "document_report", :on => :collection
    get "document_report2", :on => :collection
    get "document_report3", :on => :collection
    get "personalize_report", :on => :collection
  end
  
  resources :users
  resources :companies
  resources :clients
  resources :providers
  resources :warehouses
  resources :products
  resources :brands
  resources :categories
  resources :documents
  resources :document_types
  resources :document_lines
  resources :stocks
  resources :payments
  resources :payments_documents
  resources :payment_types
  
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    devise_for :users, :controllers => { :registrations => "registrations"}
    
    get '/:locale/documents/search' => 'documents#search', :as => :documents_search
    get '/:locale/stocks/search' => 'stocks#search', :as => :stock_search
    get '/:locale/clients/search' => 'clients#search', :as => :client_search
    get '/:locale/providers/search' => 'providers#search', :as => :provider_search
    get '/:locale/products/search' => 'products#search', :as => :products_search
    get '/:locale/payments_documents/search' => 'payments_documents#search', :as => :payments_documents_search

    get '/:locale/companies/settings' => 'companies#settings', :as => :settings
    get '/:locale/companies/edit_formats' => 'companies#edit_formats', :as => :edit_formats     
 
    get '/:locale/clients/autocomplete' => 'clients#autocomplete', :as => :client_autocomplete
    get '/:locale/clients/get_info_account' => 'clients#get_info_from_selected_account', :as => :get_info_client

    get '/:locale/providers/autocomplete' => 'providers#autocomplete', :as => :provider_autocomplete
    get '/:locale/providers/get_info_account' => 'providers#get_info_from_selected_account', :as => :get_info_provider

    get '/:locale/warehouses/autocomplete' => 'warehouses#autocomplete', :as => :warehouse_autocomplete
    get '/:locale/warehouses/get_info_account' => 'warehouses#get_info_from_selected_account', :as => :get_info_warehouse   

    delete '/:locale/documents/remove_document_line' => 'documents#remove_document_line', :as => :document_remove_document_line
    post '/:locale/documents/create_document_line' => 'documents#create_document_line', :as => :create_document_line
    get '/:locale/documents/create_document_account' => 'documents#create_document_account', :as => :create_document_account  
    get '/:locale/documents/new' => 'documents#new', :as => :new

    get '/:locale/products/autocomplete' => 'products#autocomplete', :as => :product_autocomplete
    get '/:locale/products/get_info_product' => 'products#get_info_from_selected_product', :as => :get_info_product

    get '/:locale/payments_documents/add_payments_document_id' => 'payments_documents#add_payments_document_id', :as => :add_payments_document_id  
    get '/:locale/payments_documents/remove_payments_document_id' => 'payments_documents#remove_payments_document_id', :as => :remove_payments_document_id  
    post '/:locale/payments_documents/create_payment_line' => 'payments_documents#create_payment_line', :as => :create_payment_line
#    get '/:locale/payments_documents/new' => 'payments_documents#new', :as => :new
    get '/:locale/payments_documents/new_modal' => 'payments_documents#new_modal', :as => :new_modal
    get '/:locale/payments_documents/create_payments_document_account' => 'payments_documents#create_payments_document_account', :as => :create_payments_document_account   

    get '/:locale/learn' => 'learn#index', :as => :learn_personalize_report
    get '/:locale/privacy' => 'privacy#index', :as => :privacy
    get '/:locale/terms' => 'terms#index', :as => :terms 

    patch '/upload_logo' => 'companies#upload_logo', :as => :upload_logo
    get '/delete_logo' => 'companies#delete_logo', :as => :delete_logo
    
    get '/:locale/service_payments/subscribe_month' => 'service_payments#subscribe_month', :as => :subscribe_month 
    get '/:locale/service_payments/subscribe_year' => 'service_payments#subscribe_year', :as => :subscribe_year
  end
end
