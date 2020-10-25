require 'open-uri'
require 'nokogiri'
require_relative 'recipe.rb'

class ScraperRecipes

 def initialize(dish)
 	@dish = dish
 end

 def call
 	html = open("https://www.allrecipes.com/search?wt=#{@dish}").read
 	doc = Nokogiri::HTML(html, nil, "utf-8")
 	results = []

 	doc.search(".fixed-recipe-card").first(5).each do |element|
 	   name = element.search(".fixed-recipe-card__title-link").first.text.strip
      description = element.search(".fixed-recipe-card__description").first.text.strip
      rating = element.search(".stars.stars-5").first.attribute("data-ratingstars").value
 	  recipe_url = element.search(".fixed-recipe-card__title-link").first.attribute("href").value
      recipe_html = open(recipe_url).read
      recipe_doc = Nokogiri::HTML(recipe_html, nil, "utf-8")
      prep_time = recipe_doc.search(".recipe-meta-item-body").first.text.strip
      results << Recipe.new(name, description, prep_time, rating)
    end
 	
 	
results end

end
