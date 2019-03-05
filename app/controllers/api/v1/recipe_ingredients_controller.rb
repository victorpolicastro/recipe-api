module Api
	module V1
		class RecipeIngredientsController < ApplicationController
			#GET
			#Insert RecipeIngredients into database
			def index
				ingredients = params[:ingredients]
				recipe_id = params[:recipe_id]
				tags = params[:tags]

				destroy_ingredients = RecipeIngredient.where(recipe_id: recipe_id)
				if !destroy_ingredients.blank? 
					destroy_ingredients.delete_all 
				end
				ingredients.each do |recipe_ingredient|
					ingredient = RecipeIngredient.new
					ingredient.recipe_id = recipe_id
					ingredient.ingredient = recipe_ingredient
					ingredient.save!
				end

				redirect_to api_v1_recipe_tags_url(recipe_id: recipe_id, tags: tags)
			end

			private

			def recipe_params
				params.permit(:recipe_id, :ingredients, :tags)
			end
		end
	end
end