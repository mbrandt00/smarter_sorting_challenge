# make ingredients
40.times do 
    Ingredient.create!(name: Faker::Science.element)
end

# make products
20.times do 
    # Faker::Commerce.product_name
    product = Product.create!(name: Faker::Commerce.product_name)
    rand(1..7).times do 
        ingredient = Ingredient.all.sample(1).first
        ProductIngredient.create!(product: product, ingredient: ingredient)
    end
end