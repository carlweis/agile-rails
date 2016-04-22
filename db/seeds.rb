require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

course_apps = ['Online Marketplace', 'Project Management', 'Video Screencasts', 'Recipie Maker', 'Modern Blog', 'Instagram Clone', 'CraigsList Clone', 'Ecomerce Store']
course_apps.each do |app|
	product = Product.create!(
		title: "Create a #{app} with Ruby on Rails",
		description: Faker::Lorem.sentence(3),
		image_url: 'rails-logo.svg',
		price: rand(600)
	)
	puts product.inspect
end