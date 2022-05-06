require 'rails_helper'

RSpec.describe Product do 
    describe 'validations' do 
        it { should have_many(:product_ingredients) }
        it { should have_many(:ingredients).through(:product_ingredients) }
    end
    describe 'class methods' do 
        it 'should find all products that have matching ingredients' do 
            tomato = Ingredient.create!(name: 'tomato')
            garlic = Ingredient.create!(name: 'garlic')
            shrimp = Ingredient.create!(name: 'shrimp')
            pasta = Ingredient.create!(name: 'pasta')
            scampi = Product.create(name: 'scampi')
            [garlic, shrimp, pasta].each do |ingredient| 
                ProductIngredient.create!(product: scampi, ingredient: ingredient)
            end
            worse_pasta = Product.create(name: 'basic pasta')
            [tomato, pasta].each do |ingredient| 
                ProductIngredient.create!(product: worse_pasta, ingredient: ingredient)
            end
            matching_pasta = Product.find_with_matching_ingredient('pasta')
            expect(matching_pasta.pluck(:name)).to eq(['scampi', 'basic pasta'])
            shrimp_pasta = Product.find_with_matching_ingredient('shrimp')
            expect(shrimp_pasta.pluck(:name)).to eq(['scampi'])
            tomato_pasta = Product.find_with_matching_ingredient('tomato')
            expect(tomato_pasta.pluck(:name)).to eq(['basic pasta'])
        end
    end
end