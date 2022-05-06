require 'rails_helper'

RSpec.describe ProductIngredient do 
    describe 'associations' do 
        it { should belong_to(:ingredient) }
        it { should belong_to(:product) }
    end
end