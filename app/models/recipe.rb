class Recipe < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :ingredients, inverse_of: :recipe
  has_many :instructions, inverse_of: :recipe

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :instructions
end
