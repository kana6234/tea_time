class Item < ApplicationRecord
  has_many_attached :images
  has_one :post, as: :postable, dependent: :destroy
  accepts_nested_attributes_for :post, allow_destroy: true, update_only: true

  validates :website, presence: true
  validates :post, presence: true
end
