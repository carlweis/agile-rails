require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  
  test 'buying a product' do
  	LineItem.delete_all
  	Order.delete_all
  	ruby_book = products(:ruby)

  	# navigate to the store
  	get '/'
  	assert_response :success
  	assert_template 'index'

  	# add a product to the cart
  	xml_http_request :post, '/line_items', product_id: ruby_book.id
  	assert_response :success

  	cart = Cart.find_by(id: session[:cart_id])
  	assert_equal 1, cart.line_items.size
  	assert_equal ruby_book, cart.line_items[0].product

  	# test checkout
  	get '/orders/new'
  	assert_response :success
  	assert_template 'new'

  	post_via_redirect '/orders',
  		order: {
  			name: 'Carl Weis',
  			address: '1234 Main Street',
  			email: 'carl@example.org',
  			payment_type_id: payment_types(:card).id
  		}
  	assert_response :success
  	assert_template 'index'
  	cart = Cart.find_by(id: session[:cart_id])
  	assert_equal 0, cart.line_items.size

  	# verify order was created
  	orders = Order.all
  	assert_equal 1, orders.size
  	order = orders[0]

  	assert_equal 'Carl Weis', order.name
  	assert_equal '1234 Main Street', order.address
  	assert_equal 'carl@example.org', order.email
  	assert_equal payment_types(:card), order.payment_type

  	# verify the email was sent to the customer
  	mail = ActionMailer::Base.deliveries.last
  	assert_equal ['carl@example.org'], mail.to
  	assert_equal 'Carl Weis <carl@carlweis.com>', mail[:from].value
  	assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

end
