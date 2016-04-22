require 'test_helper'

class CartTest < ActiveSupport::TestCase
	def setup	
		@cart = carts(:one)
	end

	test 'has valid items in cart' do
		@cart.add_product(products(:ruby).id)
		@cart.add_product(products(:rails).id)
		@cart.save!
		assert_equal @cart.line_items.size, 4
		assert_equal @cart.total_price, 190
	end
end
