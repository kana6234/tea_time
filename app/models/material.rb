class Material < ApplicationRecord
  belongs_to :recipe, optional: true

  validates :name, presence: true, length: { maximum: 20 }
  validates :quantity, presence: true, length: { maximum: 10 }
end
