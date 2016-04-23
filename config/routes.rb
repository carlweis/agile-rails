Rails.application.routes.draw do
  root 'store#index', as: 'store'
  
  get 'admin' => 'admin#index'

  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  resources :users
  resources :orders
  
  
  resources :products do
    get :who_bought, on: :member
  end
  
  resources :line_items do
  	member do
  		post 'decrement'
  		post 'increment'
  	end
  end

  resources :carts

end
