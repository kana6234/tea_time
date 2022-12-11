class Shop < ApplicationRecord
  has_many_attached :images
  has_one :post, as: :postable, dependent: :destroy
  has_many :business_hours, dependent: :destroy
end
