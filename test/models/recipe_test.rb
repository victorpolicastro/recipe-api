require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  test "recipe attributes must not be empty" do
  	recipe = Recipe.new
  	assert recipe.invalid?
  	assert recipe.errors[:name].any?
  	assert recipe.errors[:preparation_method].any?
  end
end
