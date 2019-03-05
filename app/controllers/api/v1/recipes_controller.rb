module Api
	module V1
		class RecipesController < ApplicationController

			#GET
			#Receive all recipes from database
			def index
				recipe_name = params[:name]
				recipe_ingredients = params[:ingredients]
				recipe_tag = params[:tag]

				recipes = get_recipes(recipe_name, recipe_tag, recipe_ingredients)

				render json: {status: 'SUCCESS', message: 'Loaded recipes', data: recipes}, status: :ok
			end

			#POST
			#Insert a recipe into database
			def create
				recipe = Recipe.new(recipe_params)
				ingredients = params[:ingredients]
				tags = params[:tags]
				
				if recipe.save
					if !ingredients.blank?
						redirect_to api_v1_recipe_ingredients_url(recipe_id: recipe.id, ingredients: ingredients, tags: tags)
					end
				else
					render json: {status: 'ERROR', message: 'Recipe not saved', data: recipe.errors}, status: :unprocessable_entity
				end
			end

			#PUT
			#Update a recipe
			def update
				recipe = Recipe.find(params[:id])
				ingredients = params[:ingredients]
				tags = params[:tags]

				if recipe.update_attributes(recipe_params)
					if !ingredients.blank?
						create_ingredient(recipe.id, ingredients)
					end

					if !tags.blank?
						create_tag(recipe.id, tags)
					end

					render json: {status: 'SUCCESS', message: 'Updated recipe', data: get_recipe_by_id(recipe.id)}, status: :ok
				else
					render json: {status: 'ERROR', message: 'Recipe not updated', data: recipe.errors}, status: :unprocessable_entity
				end
			end

			#DELETE
			#Delete a recipe
			def destroy
				recipe = get_recipe_by_id(params[:id])
				recipe.destroy
				render json: {status: 'SUCCESS', message: 'Deleted recipe', data: recipe}, status: :ok
			end

			#Create the ingredients for the recipe
			# recipe_id: id of the recipe
			# ingredients: list of ingredients for a recipe
			def create_ingredient(recipe_id, ingredients)
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
			end

			#Create the tags for the recipe
			# recipe_id: id of the recipe
			# tags: list of tags for a recipe
			def create_tag(recipe_id, tags)
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
			end

			#Find all recipes matching the parameters
			# recipe_name: name of the recipe
			# recipe_tag: a single tag for a recipe
			# recipe_ingredients: list of ingredients
			def get_recipes(recipe_name, recipe_tag, recipe_ingredients)
				recipes_ids = Set.new
				ingredients_upcase = Set.new
				#search by
				case
				when !recipe_name.blank?
					recipes_ids = Recipe.where('UPPER(name) LIKE UPPER(?)', "%#{recipe_name}%").pluck(:id)
				when !recipe_tag.blank?
					recipes_ids = RecipeTag.where('UPPER(tag) LIKE UPPER(?)', "%#{recipe_tag}%").pluck(:recipe_id)
				when !recipe_ingredients.blank?

					ingredients = recipe_ingredients.to_s.delete "["
					ingredients = ingredients.delete "]"
					ingredients = ingredients.delete " "

					ingredients_array = ingredients.split(",") 

					ingredients_array.each do |ingredient|
						ingredients_upcase << ingredient.upcase
					end

					recipes_ids = RecipeIngredient.where('UPPER(ingredient) IN (?)', ingredients_upcase).pluck(:recipe_id)
				else
					recipes_ids = Recipe.all.pluck(:id)
				end
				#get recipes matching the ID
				if !recipes_ids.blank?
					recipes = Recipe.where("id IN (?)", recipes_ids).order('created_at DESC')
					#get tags and ingredients for each recipe
					recipes.each do |recipe|
						recipe.tags = RecipeTag.where('recipe_id = ?', recipe.id).pluck(:tag)
						recipe.ingredients = RecipeIngredient.where('recipe_id = ?', recipe.id).pluck(:ingredient)
					end

					return recipes
				end
			end

			#Get a single recipe matching the parameter
			# recipe_id: id of a recipe
			def get_recipe_by_id(recipe_id)
				recipe = Recipe.find_by(id: recipe_id)
				recipe.tags = RecipeTag.where('recipe_id = ?', recipe.id).pluck(:tag)
				recipe.ingredients = RecipeIngredient.where('recipe_id = ?', recipe.id).pluck(:ingredient)

				return recipe
			end

			private

			def recipe_params
				params.permit(:name, :preparation_method, :preparation_time, :efficiency, :ingredients, :tags)
			end
		end
	end
end