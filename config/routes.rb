Rails.application.routes.draw do

  default_url_options host: 'localhost', port: 3000
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  get 'login' => 'session#login'
  post 'login' => 'session#create'
  delete 'logout' => 'session#destroy'
  post 'contact_logs' => 'session#contact_us'
  get 'about_us' => 'about#index'
  get 'sign_up' => 'admin/users#new'

  namespace :admin do
    get 'user_roles' => 'users#index'
    post 'users' => 'users#create', as: 'users'
    patch 'user/:id/roles' => 'users#roles', as: 'role'
    delete 'user/:id' => 'users#destroy', as: 'user'
    get 'user/:id' => 'users#profile'
    patch 'user/:id' => 'users#update'
    post 'user_bios' => 'users#create_bio', as: 'user_bios'
    patch 'user_bio/:id' => 'users#update_bio', as: 'user_bio'
  end

  resources :user_classes
  resources :user_bios

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
