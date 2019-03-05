# README

This API was made to receive/send recipes. The actions are:
- Get all recipes or filter by name or categories or list of ingredients;
- Create a recipe;
- Update a recipe;
- Delete a recipe;

# Tables:
- recipes
- recipe_ingredients
- recipe_tag

# Technology:
- Ruby: 2.6.1
- Rails: 5.2.2
- Database: PostgreSQL

# API Payload:
{
    "name": "",
    "preparation_time": ,
    "efficiency": ,
    "preparation_method": "",
    "tags": ["", ""],
    "ingredients": ["", ""]
}

# How to run:
1. Configure your database with the user "rails" and password "rails";
2. Access the project's directory;
3. Run the command "bundle" to install all gems;
4. Run the command "rails db:create db:migrate" to migrate the databases into PostgreSQL;
5. Run the command "rails s" to initizalize the server. It will start at port 3000.

# How to test:
1. To test the models run "rails test:models"
2. To test the controllers run "rails test:controllers"

# Using the API:
- Get all recipes in database:
	METHOD: GET
	URL: http://localhost:3000/api/v1/recipes
- Get all recipes matching a name
	METHOD: GET
	URL: http://localhost:3000/api/v1/recipes?name=NAME
- Get all recipes matching a tag
	METHOD: GET
	URL: http://localhost:3000/api/v1/recipes?tag=TAG
- Get all recipes matching a list of ingredients
	METHOD: GET
	URL: http://localhost:3000/api/v1/recipes?ingredients=NAME
- Insert a recipe into database:
	METHOD: POST
	URL: http://localhost:3000/api/v1/recipes
- Update a recipe:
	METHOD: POST
	URL: http://localhost:3000/api/v1/recipes/RECIPE_ID
- Delete a recipe:
	METHOD: DELETE
	URL: http://localhost:3000/api/v1/recipes/RECIPE_ID
