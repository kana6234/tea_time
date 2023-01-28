class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags, dependent: :destroy
  has_many :recipes, through: :posts, dependent: :destroy
  has_many :shops, through: :posts, dependent: :destroy
  has_many :items, through: :posts, dependent: :destroy
  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }

  scope :is_recipe, -> { eager_load(:recipes).where.not(recipes: { id: nil}) }
  scope :is_item, -> { eager_load(:items).where.not(items: { id: nil}) }
  scope :tea_name, -> { where(tea_name: true) }
end
