Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get :root, to: 'welcome#index'

  get '/', to: 'welcome#index', as: 'root'

  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  get '/merchants/:id', to: 'merchants#show'
  delete '/merchants/:id', to: 'merchants#destroy', as: 'merchant'
  get '/merchants/:merchant_id/items', to: 'items#index'
  # resources :merchants do
  #   resources :items, only: [:index]
  # end

  get '/items', to: 'items#index'
  get '/items/:id', to: 'items#show', as: 'item'
  get '/items/:item_id/reviews/new', to: 'reviews#new', as: 'new_item_review'
  post '/items/:item_id/reviews', to: 'reviews#create', as: 'item_reviews'
  # resources :items, only: [:index, :show] do
  #   resources :reviews, only: [:new, :create]
  # end

  get '/reviews/:id/edit', to: 'reviews#edit', as: 'edit_review'
  patch '/reviews/:id', to: 'reviews#update', as: 'review'
  delete '/reviews/:id', to: 'reviews#destroy'
  # resources :reviews, only: [:edit, :update, :destroy]

  get '/cart', to: 'cart#show'
  post '/cart/:item_id', to: 'cart#add_item'
  delete '/cart', to: 'cart#empty'
  patch '/cart/:change/:item_id', to: 'cart#update_quantity'
  delete '/cart/:item_id', to: 'cart#remove_item'

  get '/registration', to: 'users#new', as: :registration
  resources :users, only: [:create, :update]
  # patch '/user/:id', to: 'users#update'

  get '/profile', to: 'users#show'
  get '/profile/edit', to: 'users#edit'
  get '/profile/edit_password', to: 'users#edit_password'

  resources :orders, only: [:new, :create], module: :user
  # get '/orders/new', to: 'user/orders#new'
  # post '/orders', to: 'user/orders#create'

  scope :profile, module: :user do
    resources :orders, only: [:index, :show]
  end
  # get '/profile/orders', to: 'user/orders#index'
  # get '/profile/orders/:id', to: 'user/orders#show'
  get '/profile/orders/:id/change_address', to: 'user/orders#change_address'
  post '/profile/orders/:id/change_address', to: 'user/orders#update_address'
  delete '/profile/orders/:id', to: 'user/orders#cancel'

  scope :profile, module: :user do
    resources :addresses, except: [:show, :create]
  end
  # get '/profile/addresses/new', to: 'user/addresses#new'
  post '/profile/addresses/new', to: 'user/addresses#create'
  # get '/profile/addresses/:id/edit', to: 'user/addresses#edit'
  # patch '/profile/addresses/:id', to: 'user/addresses#update'
  # delete '/profile/addresses/:id', to: 'user/addresses#destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#login'
  get '/logout', to: 'sessions#logout'

  get '/merchant', to: 'merchant/dashboard#index', as: 'merchant_dashboard'
  get '/merchant/orders/:id', to: 'merchant/orders#show'
  get '/merchant/items', to: 'merchant/items#index'
  get '/merchant/items/new', to: 'merchant/items#new'
  post '/merchant/items', to: 'merchant/items#create'
  get '/merchant/items/:id/edit', to: 'merchant/items#edit'
  patch '/merchant/items/:id', to: 'merchant/items#update'
  put '/merchant/items/:id', to: 'merchant/items#update'
  delete '/merchant/items/:id', to: 'merchant/items#destroy'
  put '/merchant/items/:id/change_status', to: 'merchant/items#change_status'
  get '/merchant/orders/:id/fulfill/:order_item_id', to: 'merchant/orders#fulfill'
  # namespace :merchant do
  #   get '/', to: 'dashboard#index', as: :dashboard
  #   resources :orders, only: :show
  #   resources :items, only: [:index, :new, :create, :edit, :update, :destroy]
    # put '/items/:id/change_status', to: 'items#change_status'
    # get '/orders/:id/fulfill/:order_item_id', to: 'orders#fulfill'
  # end

  get '/admin', to: 'admin/dashboard#index', as: 'admin_dashboard'
  get '/admin/merchants/:id', to: 'admin/merchants#show'
  patch '/admin/merchants/:id', to: 'admin/merchants#update'
  get '/admin/users', to: 'admin/users#index'
  get '/admin/users/:id', to: 'admin/users#show'
  patch '/admin/orders/:id/ship', to: 'admin/orders#ship'

  # namespace :admin do
    # get '/', to: 'dashboard#index', as: :dashboard
    # resources :merchants, only: [:show, :update]
    # resources :users, only: [:index, :show]
    # patch '/orders/:id/ship', to: 'orders#ship'
  # end
end
