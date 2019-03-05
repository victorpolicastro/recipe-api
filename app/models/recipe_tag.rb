class RecipeTag < ApplicationRecord
  belongs_to :recipe
  validates :tag, presence: true

end
