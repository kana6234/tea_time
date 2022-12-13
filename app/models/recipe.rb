class Recipe < ApplicationRecord
  has_one :post, as: :postable, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :materials, dependent: :destroy
  accepts_nested_attributes_for :post, :steps, :materials, allow_destroy: true, update_only: true

  validates :serves, presence: true
  validates :post, presence: true
  validates :steps, presence: true
  validates :materials, presence: true
end
