Pymenta::Application.routes.draw do
 
  resources :brands


  resources :products


  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :companies

    authenticated :user do
      root :to => 'home#index'
    end
    root :to => "home#index"
    devise_for :users, :controllers => { :registrations => "registrations"}
    resources :users
  end  

end