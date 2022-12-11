class Item < ApplicationRecord
  has_many_attached :images
  has_one :post, as: :postable, dependent: :destroy
end
