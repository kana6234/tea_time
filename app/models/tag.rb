class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags, dependent: :destroy
  has_many :recipes, through: :posts, dependent: :destroy
  has_many :shops, through: :posts, dependent: :destroy
  has_many :items, through: :posts, dependent: :destroy

  validates :name, presence: true
end
