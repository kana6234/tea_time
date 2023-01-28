class Recipe < ApplicationRecord
  belongs_to :post, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :materials, dependent: :destroy
  has_many :post_tags, through: :post
  has_many :post_comments, through: :post
  accepts_nested_attributes_for :post, :steps, :materials, allow_destroy: true, update_only: true

  validates :serves, presence: true, length: { in: 1..5 }
  validates :post, presence: true
  validates :steps, presence: true
  validates :materials, presence: true
end
