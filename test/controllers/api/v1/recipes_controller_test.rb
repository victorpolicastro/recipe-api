require 'test_helper'

module Api
	module V1
		class RecipesControllerTest < ActionDispatch::IntegrationTest
			setup do
				@recipe = recipes(:one)
				@update = {
					name: 				'Lorem Ipsum',
					preparation_time: 	'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.'
				}
			end

			test "should create recipe" do
				post api_v1_recipes_url, params: { recipe: @update }			
			end

			test "should update recipe" do
				put api_v1_recipe_url(@recipe), params: { recipe: @update }
			end

			test "should delete recipe" do
				delete api_v1_recipe_url(@recipe)
			end
		end
	end
end