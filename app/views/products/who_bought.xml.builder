@product.to_xml(include: :orders)
xml.rss("version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/") do
	xml.channel do
		xml.title(@product.title)
		xml.link(product_path(@product))
		xml.description "Latest Orders Feed"
		xml.language "en-us"
		xml.ttl "40"

		@product.orders.each do |order|
			xml.order do
				xml.title("Order ID #{order.id}")
				xml.description("Shipped to #{order.address}")
				xml.pubDate(order.created_at)
				order.line_items.each do |item|
					xml.tag!("item") do
						xml.tag!("title", item.product.title)
						xml.tag!("quantity", item.quantity)
						xml.tag!("total", number_to_currency(item.total_price))
					end
				end
			end
			xml.subtotal number_to_currency order.line_items.map(&:total_price).sum
			xml.payment "Paid by #{order.payment_type.name}"
			xml.tag!("customer") do
				xml.name order.name
				xml.email order.email
			end
		end
	end
end
