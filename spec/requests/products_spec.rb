require 'rails_helper'

RSpec.describe 'Product Requests' do 
    describe 'creating a product' do 
        describe 'happy path' do 
            it 'will create a product' do 
                post '/api/v1/products', params: {name: 'The Best Hand Sanitizer', ingredients: ['ethyl alcohol', 'isopropyl alcohol', 'water', 'dimethyl siloxane', 'copper gluconate']}
                expect(Product.all.size).to eq(1)
                expect(Product.first.ingredients.size).to eq(5)
                expect(Product.first.ingredients.first.name).to eq('ethyl alcohol')
                expect(Product.first.ingredients.second.name).to eq('isopropyl alcohol')
                expect(Product.first.ingredients.last.name).to eq('copper gluconate')
            end
            it 'will not create duplicate ingredients' do 
                Ingredient.create!(name: 'ethyl alcohol')
                post '/api/v1/products', params: {name: 'The Best Hand Sanitizer', ingredients: ['ethyl alcohol', 'isopropyl alcohol', 'water', 'dimethyl siloxane', 'copper gluconate']}
                expect(Ingredient.all.size).to eq(5)
                response_info = JSON.parse(response.body, symbolize_names: true)
                expect(response_info[:data]).to include(:id, :attributes)
                expect(response_info[:data][:attributes]).to include(:name, :ingredients)
            end
        end
        describe 'sad path' do 
            it 'will return an error if no ingredients are included in request' do
                post '/api/v1/products', params: {name: 'The Best Hand Sanitizer'}
                response_info = JSON.parse(response.body, symbolize_names:true)
                expect(response_info[:error]).to eq('Please include ingredients!')
            end
        end
    end
    describe 'all products' do 
        it 'will return all products' do 
            #create two products
            post '/api/v1/products', params: {name: 'The Best Hand Sanitizer', ingredients: ['ethyl alcohol', 'isopropyl alcohol', 'water', 'dimethyl siloxane', 'copper gluconate']}
            post '/api/v1/products', params: {name: 'The Best Pasta', ingredients: ['carbon', 'glucose', 'water', 'sodium chloride']}
            get '/api/v1/products'
            response_info = JSON.parse(response.body, symbolize_names:true)
            expect(response_info[:data].length).to eq(2)
            expect(response_info[:data].first[:attributes][:name]).to eq('The Best Hand Sanitizer')
            expect(response_info[:data].second[:attributes][:name]).to eq('The Best Pasta')
        end
    end
    describe 'contains a certain ingredient' do 
        before :each do 
            post '/api/v1/products', params: {name: 'The Best Hand Sanitizer', ingredients: ['alcohol', 'water', 'copper gluconate']}
            post '/api/v1/products', params: {name: 'The Best Martini', ingredients: ['alcohol', 'olive', 'water']}
            # these both contain water
            post '/api/v1/products', params: {name: 'The Best Pasta', ingredients: ['carbon', 'glucose', 'sodium chloride']}
        end
        it 'will return products that have a certain ingredient' do 
            get '/api/v1/with_ingredient', params: {ingredients: 'water'}
            response_info = JSON.parse(response.body, symbolize_names:true)
            expect(response_info[:data].length).to eq(2)
            expect(response_info[:data].first[:attributes][:name]).to eq('The Best Hand Sanitizer')
            expect(response_info[:data].second[:attributes][:name]).to eq('The Best Martini')
        end
        it 'will return an error if no ingredients are included' do 
            get '/api/v1/with_ingredient'
            response_info = JSON.parse(response.body, symbolize_names:true)
            expect(response_info[:error]).to eq('Please include ingredients!')
        end
    end
end