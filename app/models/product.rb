class Product < ApplicationRecord 
    has_many :product_ingredients
    has_many :ingredients, through: :product_ingredients

    def self.find_with_matching_ingredient(ingredients)
        joins(:ingredients).where(ingredients: {name: ingredients})
    end
end