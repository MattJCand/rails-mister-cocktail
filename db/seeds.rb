# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'json'
require 'open-uri'

puts 'Cleaning database...'

Cocktail.destroy_all
Ingredient.destroy_all
Dose.destroy_all

url = 'http://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
ingredient_url= open(url).read
ingredient = JSON.parse(ingredient_url)

ingredient["drinks"].each do |i|
  Ingredient.create!(name: i["strIngredient1"])
end

url_cocktail = 'http://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'
cocktail_url= open(url_cocktail).read
cocktail = JSON.parse(cocktail_url)

cocktail["drinks"].first(12).each do |i|
  c = Cocktail.new(name: i["strDrink"])
  c.photo_url = i["strDrinkThumb"]
  c.save
end

puts 'Finished'
