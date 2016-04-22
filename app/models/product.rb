class Product < ActiveRecord::Base
	has_many :line_items
	before_destroy :ensure_not_references_by_any_line_items
	validates :title, :description, :image_url, :price, presence: true
	validates :title, uniqueness: true
	validates :title, length: {minimum: 10, message: 'Book title is too short.'}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :price, numericality: {less_than_or_equal_to: 100, message: 'Book price must be less than $100'}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png|svg)\Z}i,
		message: 'must be a URL for GIF, JPG, PNG or SVG image.'
	}

	def self.latest
		Product.order(:updated_at).last
	end

	private

		# ensure that there are no line items referencing this product
		def ensure_not_references_by_any_line_items
			if line_items.empty?
				return true
			else
				errors.add(:base, 'Line Items present, cannot delete product.')
				return false
			end
		end
end
