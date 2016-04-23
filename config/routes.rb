Rails.application.routes.draw do
  
  resources :users
  resources :orders
  root 'store#index', as: 'store'
  
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
