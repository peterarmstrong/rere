Rere::Application.routes.draw do |map|
  devise_for :users, :controllers => {
    :sessions => "sessions",
    :registrations => "registrations",
    :passwords => "passwords"
  }

  root :to => "home#index"

  resources :thoughts do
    resources :comments
  end

  
  match "home/about"
  match "home/people"

  match "admin/:action" => "admin#:action", :as => :admin
  
  match 'users/:username/follow' => "users#follow", :as => :follow
  match 'users/:username/unfollow' => "users#unfollow", :as => :unfollow
  
  match 'users/:username/share' => "users#share", :as => :share

  match "group/:permalink" => "groups#show", :as => :group_permalink

  resources :groups do
    member do
      post :join
      post :leave
      post :share
    end
  end

  match ":username" => "users#stream", :as => :stream
  
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
  #       get :short
  #       post :toggle
  #     end
  #
  #     collection do
  #       get :sold
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
  #       get :recent, :on => :collection
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
