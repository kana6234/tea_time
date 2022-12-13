class Step < ApplicationRecord
  has_one_attached :image
  belongs_to :recipe, optional: true

  validates :no, presence: true
  validates :content, presence: true
end
