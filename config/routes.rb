Rails.application.routes.draw do
  # 顧客用
# URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
# 管理者用
# URL /admin/sign_in ...
devise_for :admin,skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}

  root to: "public/homes#top"
  
  namespace :admin do
    root to: "homes#top"

  end
  namespace :admin do
    resources :orders, only: [:show, :update]
    #get 'orders/show'
    #get 'orders/update'
  end
  namespace :admin do
    resources :customers, only:[:index, :show, :edit, :update]
    #get 'customers/index'
    #get 'customers/show'
    #get 'customers/edit'
    #get 'customers/update'
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    #get 'genres/index'
    #get 'genres/create'
    #get 'genres/edit'
    #get 'genres/update'
  end
  namespace :admin do
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    #get 'items/index'
    #get 'items/new'
    #get 'items/create'
    #get 'items/show'
    #get 'items/edit'
    #get 'items/update'
  end
  #namespace :public do
  
    #get 'home/top' =>'public/homes#top', as: '/'
  get '/about' =>'public/homes#about', as: 'about'
  #end
  namespace :public do
    resources :addresses, only: [:ibdex, :edit]
   # get 'addresses/index'
  #  get 'addresses/edit'
  end
  namespace :public do
    resources :orders, only: [:new, :index, :show]
    #get 'orders/new'
    #get 'orders/index'
    #get 'orders/show'
  end
  namespace :public do
    resources :cart_items, only: [:index]
   # get 'cart_items/index'
  end
  namespace :public do
    resources :customers, only: [:show, :edit]
    #get 'customers/show'
    #get 'customers/edit'
  end
  namespace :public do
    resources :items, only: [:index, :show]
    #get 'items/index'
    #get 'items/show'
  end



  #devise_for :admins
  #devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
