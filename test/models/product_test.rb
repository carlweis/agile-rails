require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

	def setup
		@product = products(:ruby)
	end

	test 'product attributes must not be empty' do
  	product = Product.new
  	assert product.invalid?
  	assert product.errors[:title].any?
  	assert product.errors[:description].any?
  	assert product.errors[:price].any?
  	assert product.errors[:image_url].any?
  end

  test 'product title must be at least 10 characters in length' do
    product = @product
    product.title = 'title'
    assert product.invalid?
    assert product.errors[:title].any?
  end

  test 'product price cannot be negative' do
  	product = @product
  	product.price = -1
  	assert product.invalid?
  	assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
	end

	test 'product price cannot be zero' do
		product = @product
		product.price = 0
		assert product.invalid?
		assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]
	end

	test 'product has a positive price' do
		product = @product
		product.price = 1
		assert product.valid?
	end

	test 'valid product image url' do
		ok = %w{fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif fred.svg FrEd.SVG }

		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"
		end
	end

	test 'invalid product image url' do
		bad = %w{ fred.doc fred.gif/more fred.gif.more }
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end

	# helper methods
	def new_product(image_url)
		Product.new(
			 title: 'My course title',
			 description: 'lorem ipsum...',
			 price: 1,
			 image_url: image_url
		)
	end
end
