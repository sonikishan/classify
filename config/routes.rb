WelocoDevise::Application.routes.draw do

  match '/rate' => 'rater#create', :as => 'rate'

  get "authentication/create"

  resources :bids

  resources :users
  resources :abuse_reports


  resources :view_counts

resources :advertisements do
    member do
      post 'bid'
    end
    member do
      post 'abuse_report'
    end
    member do
      post 'contact_advertiser'
    end
    put :favorite, on: :member
  end
  resources :favorites


  # resources :categories do
  #   resources :characteristics
  # end


  resources :characteristics


  # mount Ckeditor::Engine => '/ckeditor'


  
  # resources :advertisements
  resources :advertisements do
    member do
      post 'bid'
    end
    member do
      post 'abuse_report'
    end
    member do
      post 'contact_advertiser'
    end
    put :favorite, on: :member
  end


  resources :categories
  
  devise_for :admins

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users, :path => '',:controllers => {:sessions => "sessions"},:path_names => { :sign_in => 'login', :sign_out => 'logout' }

  match '/contact' => 'weloco_pages#contact'

  match '/profile' => 'weloco_pages#profile'
  match '/myprofile' => 'weloco_pages#myprofile'
  match '/myads' => 'weloco_pages#myads'
  match '/myfavs' => 'weloco_pages#myfavs'
  match '/myads_listing' => 'weloco_pages#myads_listing',:as => :myads_listing

  match '/getchars' => 'characteristics#getchars'
  match 'block_status/:id' => 'users#block_status',:as => :block_status
  match 'block_ip_status/:id' => 'users#block_ip_status',:as => :block_ip_status
  match 'category_status/:id' => 'categories#category_status',:as => :category_status
  match 'sub_category_status/:id' => 'categories#sub_category_status',:as => :sub_category_status
  match 'destroy_category/:id' => 'categories#destroy_category',:as => :destroy_category
  match 'move_ads' => 'categories#move_ads',:as => :move_ads
  match 'advertisement_list/:id' => 'categories#advertisement_list', :as => :advertisement_list
  match 'sub_category_child_status/:id' => 'categories#sub_category_child_status',:as => :sub_category_child_status
  match 'destroy_category_ads/:id' => "categories#destroy_category_ads",:as => :destroy_category_ads
  match 'category_listing/:id'  => "categories#category_listing" , :as => :category_listing
  match 'category_filtering/:id/:parent_id'  => "categories#category_filtering" , :as => :category_filtering
  match 'price_search(/:value)' => "categories#price_search", :as => :price_search
  match 'auth/:provider/callback' => 'authentication#create'
  match '/advertisements/:id' => 'advertisements#show', :as => :advertisement_show
  match '/step4_ad/:data' => 'advertisements#step4_ad', :as => :step4_ad
  match 'abuse_ad_status/:id' => 'advertisements#abuse_ad_status',:as => :abuse_ad_status
  match 'first_phase/:id' => "advertisements#first_phase"
   match 'second_phase/:id' => "advertisements#second_phase"
   match 'large_img/:id' => 'advertisements#large_img',:as => :large_img
   match 'select_large_image/:id' => 'advertisements#select_large_image', :as => :select_large_image
   match 'characteristics_list/:id/:status(/:ad_id)' => 'advertisements#characteristics_list',:as => :characteristics_list
   match '/abuse_ads_listing_admin' => 'advertisements#abuse_ads_listing_admin',:as => :abuse_ads_listing_admin
   match '/search_abuse_ad' => 'advertisements#search_abuse_ad',:as => :search_abuse_ad
   match '/select_input_kind/:status' => 'characteristics#select_input_kind',:as => :select_input_kind
  # get 'advertisements/getchars' => 'advertisements#getchars', :as => :get_chars

  # match '/profile/:id/edit', :to => 'profile#show', :as => :user

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
    root :to => 'weloco_pages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
