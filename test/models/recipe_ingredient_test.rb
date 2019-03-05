require 'test_helper'

class RecipeIngredientTest < ActiveSupport::TestCase
  test "recipe_ingredient attributes must not be empty" do
  	recipe_ingredient = RecipeIngredient.new
  	assert recipe_ingredient.invalid?
  	assert recipe_ingredient.errors[:ingredient].any?
  end
end
