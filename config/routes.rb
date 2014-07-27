Rails.application.routes.draw do

  devise_for :admins
  resources :posts

  get 'admins/settings' => 'administrators#settings', as: :settings
  patch 'admins/settings' => 'administrators#update', as: :update_settings

  get 'keywords/new' => 'administrators#newkeyword', as: :new_keyword
  post 'keywords/new' => 'administrators#keywordcreate'
  delete 'keywords/:id' => 'administrators#keyworddestroy', as: :keyword


  get 'authors/new' => 'administrators#newauthor', as: :new_author
  post 'authors/new' => 'administrators#authorcreate'
  delete 'authors/:id' => 'administrators#authordestroy', as: :author


  get 'filteredwords/new' => 'administrators#newfilteredword', as: :new_filteredword
  post 'filteredwords/new' => 'administrators#filteredwordcreate'
  delete 'filteredwords/:id' => 'administrators#filteredworddestroy', as: :filteredword

  root 'posts#main'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
