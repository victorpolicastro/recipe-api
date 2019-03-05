class Recipe < ApplicationRecord
	validates :name, :preparation_method, presence: true
	has_many :recipe_ingredients, dependent: :destroy
	has_many :recipe_tags, dependent: :destroy
	after_initialize :default_value, if: :new_record?


	def default_value
		self.ingredients = nil
		self.tags = nil
	end
end