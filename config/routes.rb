Rails.application.routes.draw do

  resources :rooms do
    resources :attachments
  end

  resources :users do
    member do
      get 'profile' => "users#show"
      get 'phone_verify' => "users#phone_verify"
      post 'verify_pin' => "users#verify_pin"
      get 'resend_pin' => "users#resend_pin"
      post '/connect_with_zuker' => "facebook/users#connect_with_zuker", :as => :connect_with_zuker
    end
    collection do
      get 'signup' => "users#new"
    end
  end

  root 'users#new'

  scope :controller => 'sessions' do
    post 'signin' => :create
    get 'signout' => :destroy
  end

  get '/auth/facebook/callback' => "facebook/sessions#create"

  namespace :facebook do
    scope :controller => 'sessions' do
      get '/signin' => 'sessions#new', :as => :signin
      get '/signout' => 'sessions#destroy', :as => :signout
    end
  end

  #post 'twilio/voice' => 'twilio#voice'
  scope :path => '/notifications', :controller => 'notifications', :as => "sms" do
    post 'notify' => :notify, :as => 'notify'
    post 'status' => :status, :as => 'status'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
