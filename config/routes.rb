Rails.application.routes.draw do

#  mount Wirispluginengine::Engine => 'wirispluginengine'

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

  get 'prep/event' => 'admin/events#index', as:'prep_event'
  get 'prep/event/new' => 'admin/events#new'
  post 'prep/event/new' => 'admin/events#create'
  post 'prep/event/update/:id' => 'admin/events#update', as: 'prep_event_update'
  delete 'prep/event/destroy/:id' => 'admin/events#destroy', as: 'prep_event_destroy'
  get 'prep/event/edit/:id' => 'admin/events#edit', as: 'prep_event_edit'
  get 'prep/reservation' => 'reservations#index', as:'prep_reservation'
  post 'prep/enroll/online' => 'reservations#index', as: 'prep_enroll_online'
  post 'prep/enroll' => 'reservations#new', as:'prep_enroll'
  post 'prep/enroll/edit' => 'reservations#edit', as:'prep_enroll_edit'
  post 'prep/reservation' => 'reservations#create'
  post 'prep/enroll/update/:id' => 'reservations#update', as: 'prep_enroll_update'
  delete 'prep/reservation/destroy/:id' => 'reservations#destroy', as: 'prep_reservation_destroy'

  namespace :admin do
    get 'prep' => 'prep#index'
    get 'prep/new' => 'prep#new'
    post 'venues' => 'prep#create'
    patch 'venue/:id' => 'prep#update'
    delete 'venue/:id' => 'prep#destroy', as: 'venue'
    get 'venue/edit/:id' => 'prep#edit', as: 'venue_edit'
    delete 'user/:id' => 'users#destroy', as: 'user'
    get 'user/:id' => 'users#profile'
    post 'users' => 'users#create', as: 'users'
    patch 'user/:id' => 'users#update'
    get 'captchas' => 'admins#captchas'
    post 'captcha/create' => 'admins#create_captcha', as: 'captcha_images'
    get 'captchas/destroy/:id' => 'admins#destroy_captcha', as: 'captcha_destroy'
    get 'user_roles' => 'users#index'
    patch 'user/:id/roles' => 'users#roles', as: 'role'
    post 'user_bios' => 'users#create_bio', as: 'user_bios'
    patch 'user_bio/:id' => 'users#update_bio', as: 'user_bio'
    get 'user_pov/:id' => 'users#edit_pov', as: 'edit_pov'
    patch 'user_pov/:id' => 'users#update_pov'
    post 'user_povs' => 'users#create_pov', as: 'user_povs'
    delete 'user_pov/:id' => 'users#destroy_pov', as: 'user_pov'
    post 'offering_pov/:id' => 'offerings#assign_pov', as: 'assign_pov'
    post 'offering_testimony/:id' => 'offerings#assign_testimony', as: 'assign_testimony'
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
