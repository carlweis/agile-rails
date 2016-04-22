module CurrentCart
	extend ActiveSupport::Concern

	private
		def set_cart
			@cart = Cart.find_by(id: session[:cart_id])
		rescue ActiveRecord::RecordNotFound
			@cart = Cart.create
			session[:cart_id] = @cart.id
		end
end