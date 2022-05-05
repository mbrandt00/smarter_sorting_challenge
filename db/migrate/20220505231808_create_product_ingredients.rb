class CreateProductIngredients < ActiveRecord::Migration[5.2]
  def change
    create_table :product_ingredients do |t|
      t.references :ingredient, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
