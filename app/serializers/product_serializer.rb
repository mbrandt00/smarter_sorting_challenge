class ProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :ingredients
end
