class Recipe < ApplicationRecord
  has_one :post, as: :postable, dependent: :destroy
end
