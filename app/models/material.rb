class Material < ApplicationRecord
  belongs_to :recipe, optional: true

  validates :name, presence: true
  validates :quantity, presence: true
end
