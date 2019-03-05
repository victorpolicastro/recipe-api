module Api
	module V1
		class RecipeTagsController < ApplicationController
			#GET
			#Insert RecipeTags into database
			def index
				recipe_id = params[:recipe_id]
				tags = params[:tags]

				destroy_tags = RecipeTag.where(recipe_id: recipe_id)
				if !destroy_tags.blank? 
					destroy_tags.delete_all
				end
				tags.each do |recipe_tag|
					tag = RecipeTag.new
					tag.recipe_id = recipe_id
					tag.tag = recipe_tag
					tag.save!
				end
				render json: {status: 'SUCCESS', message: 'Saved recipe', data: get_recipe_by_id(recipe_id)}, status: :ok
			end

			def get_recipe_by_id(recipe_id)
				recipe = Recipe.find_by(id: recipe_id)
				recipe.tags = RecipeTag.where('recipe_id = ?', recipe.id).pluck(:tag)
				recipe.ingredients = RecipeIngredient.where('recipe_id = ?', recipe.id).pluck(:ingredient)

				return recipe
			end

			private

			def recipe_params
				params.permit(:recipe_id, :tags)
			end
		end
	end
end