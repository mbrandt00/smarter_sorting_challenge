class Api::V1::ProductsController < ApplicationController

    def index 
        render json: ProductSerializer.new(Product.all)
    end

    def create 
        if params[:ingredients].nil?
            render json: {error: 'Please include ingredients!'}
        else
            product = Product.create(name: params[:name])
            params[:ingredients].each do |ingredient| 
                #check if ingredient is in DB
                ingredient = Ingredient.where(name: ingredient).any? ? Ingredient.where(name: ingredient).first : Ingredient.create(name: ingredient)
                ProductIngredient.create(product: product, ingredient: ingredient)
            end
            render json: ProductSerializer.new(product)
        end
    end
    
    def with_ingredient 
        if params[:ingredients].nil?
            render json: {error: 'Please include ingredients!'}
        else
            products = Product.find_with_matching_ingredient(params[:ingredients])
            render json: ProductSerializer.new(products)
        end
    end
end