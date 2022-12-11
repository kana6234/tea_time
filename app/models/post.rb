class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :postable, polymorphic: true
  has_many :post_tags, dependent: :destroy
end
