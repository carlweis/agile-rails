class Product < ActiveRecord::Base
	validates :title, :description, :image_url, :price, presence: true
	validates :title, uniqueness: true
	validates :title, length: {minimum: 10, message: 'Course title is too short.'}
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png|svg)\Z}i,
		message: 'must be a URL for GIF, JPG, PNG or SVG image.'
	}
end
