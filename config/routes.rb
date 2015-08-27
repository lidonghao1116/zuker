Rails.application.routes.draw do

  get 'rooms/new'

  resources :attachments

  concern :commentable do
    member do
      post 'new_comment'
    end
  end

  post 'comments/:id/new_comment' => 'comments#new_comment', as: :new_comment_comment

  resources :houses, concerns: :commentable do
    member do
      get "basic" => "houses#basic"
      get "space" => "houses#space"
      get "amenity" => "houses#amenity"
      get "description" => "houses#description"
      get "photo" => "houses#photo"
      get "date_status" => "houses#date_status"
      get "rooms" => "houses#rooms"
    end
    resources :rooms, except: [:index, :show]
  end

  concern :sms_confirmable do
    member do
      get 'phone_verify'
      post 'verify_pin'
      get 'resend_pin'
    end
  end

  resources :users, except: [:index], concerns: [:sms_confirmable, :commentable] do
    member do
      get 'profile' => "users#show"
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
  #     #     resources :sales do
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
