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
  get 'image_show' => 'session#image_show'
  get 'about_us' => 'about#index'
  get 'pm' => 'about#pm_offering'
  get 'partner' => 'about#partnering'
  get 'about_team' => 'about#our_team'
  get 'sign_up' => 'admin/users#new'

  get 'offerings' => 'offerings#index'

  namespace :admin do
    get 'user_roles' => 'users#index'
    post 'users' => 'users#create', as: 'users'
    patch 'user/:id/roles' => 'users#roles', as: 'role'
    delete 'user/:id' => 'users#destroy', as: 'user'
    get 'user/:id' => 'users#profile'
    patch 'user/:id' => 'users#update'
    post 'user_bios' => 'users#create_bio', as: 'user_bios'
    patch 'user_bio/:id' => 'users#update_bio', as: 'user_bio'
    post 'user_povs' => 'users#create_pov', as: 'user_povs'
    delete 'user_pov/:id' => 'users#destroy_pov', as: 'user_pov'
    post 'offering_pov/:id' => 'offerings#assign_pov', as: 'assign_pov'
    post 'offering_image' => 'offerings#new_image', as: 'add_image'
    post 'offering_images' => 'offerings#create_image', as: 'offering_images'
    delete 'offering_image/:id' => 'offerings#destroy_image', as: 'offering_image'
    get 'offering_image/:id' => 'offerings#edit_image'
    patch 'offering_image/:id' => 'offerings#update_image'
    post 'content' => 'offerings#new_content', as: 'add_content'
    post 'contents' => 'offerings#create_content', as: 'contents'
    delete 'content/:id' => 'offerings#destroy_content', as: 'content'
    get 'content/:id' => 'offerings#edit_content'
    patch 'content/:id' => 'offerings#update_content'
    post 'stat' => 'offerings#new_stat', as: 'add_stat'
    post 'stats' => 'offerings#create_stat', as: 'stats'
    delete 'stat/:id' => 'offerings#destroy_stat', as: 'stat'
    get 'stat/:id' => 'offerings#edit_stat'
    patch 'stat/:id' => 'offerings#update_stat'
    resources :offerings
    # get 'escents' => 'escents#index'
    # get 'escent' => 'escents#new'
    # post 'escents' => 'escents#create'
    # get 'escent/:id' => 'escents#edit', as: 'edit_escent'
    # patch 'escent/:id' => 'escents#update'
    # delete 'escent/:id' => 'escents#destroy'
    resources :escents, except: :show
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
