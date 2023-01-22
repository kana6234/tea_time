class Item < ApplicationRecord
  has_many_attached :images
  belongs_to :post, dependent: :destroy
  has_many :post_tags, through: :post
  has_many :post_comments, through: :post
  accepts_nested_attributes_for :post, allow_destroy: true, update_only: true

  validates :website, presence: true
  validates :post, presence: true

  def get_image(image)
    image.variant(resize: "100x100^", gravity: "center", crop: "100x100+0+0").processed
  end
end
