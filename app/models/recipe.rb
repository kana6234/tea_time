class Recipe < ApplicationRecord
  has_one :post, as: :postable, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :materials, dependent: :destroy
end
