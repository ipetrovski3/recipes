class Recipe < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  has_many :ingredients, inverse_of: :recipe, dependent: :destroy
  has_many :instructions, inverse_of: :recipe, dependent: :destroy

  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :instructions, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true
end
