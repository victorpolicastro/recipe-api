require 'test_helper'

class RecipeTagTest < ActiveSupport::TestCase
 test "recipe_tag attributes must not be empty" do
  	recipe_tag = RecipeTag.new
  	assert recipe_tag.invalid?
  	assert recipe_tag.errors[:tag].any?
  end
end
