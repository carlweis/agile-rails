json.content @product.title
json.link product_url(@product)
json.description "Latest Orders Feed"
@product.orders.each do |order|
	json.order do
		json.id order.id
		json.customer do
			json.customer order.name
			json.email order.email
			json.shippedTo order.address
		end
		json.createdAt order.created_at
		json.item do
			order.line_items.each do |item|
				json.title item.product.title
				json.quantity item.quantity
				json.total number_to_currency(item.total_price)
			end
		end
		json.subtotal number_to_currency(order.line_items.map(&:total_price).sum)
		json.payment order.payment_type.name
	end
end