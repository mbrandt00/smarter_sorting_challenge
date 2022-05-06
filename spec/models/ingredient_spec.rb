require 'rails_helper'

RSpec.describe Ingredient do 
    describe 'associations' do 
        it { should have_many(:product_ingredients) }
        it { should have_many(:products).through(:product_ingredients) }
    end
end