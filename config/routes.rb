Rails.application.routes.draw do

  devise_for :admins
  resources :posts
  resources :adminposts
  resources :userposts

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

  get 'admin/' => 'administrators#index', as: :admin
  root 'administrators#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:

  
end
