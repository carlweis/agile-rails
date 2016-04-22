Rails.application.routes.draw do
  
  resources :orders
  root 'store#index', as: 'store'
  
  resources :products
  resources :line_items do
  	member do
  		post 'decrement'
  		post 'increment'
  	end
  end

  resources :carts

end
