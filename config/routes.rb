Rails.application.routes.draw do
  namespace 'api' do
  	namespace 'v1' do
  		resources :recipes
  		resources :recipe_ingredients
  		resources :recipe_tags
  	end
  end

  root 'api/v1/recipes#index'
end
