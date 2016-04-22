require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

books = ['Programming Ruby 2.0', 'Agile Web Development with Ruby on Rails', 'Coffeescript Unleashed', 'Style your site with SASS', 'Git Workflow']
difficulty_levels = ['Beginner', 'Intermediate', 'Advanced', 'Expert', 'All']
books.each do |book|
	product = Product.create!(
		title: book,
		description: "<p>#{Faker::Lorem.paragraph(3)}</p>",
		image_url: 'ruby.jpg',
		price: rand(60),
	)
	puts product.inspect
end