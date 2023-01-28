class Step < ApplicationRecord
  has_one_attached :image
  belongs_to :recipe, optional: true

  validates :content, presence: true, length: { maximum: 100 }

  def get_image
    image.variant(resize: "100x130^", gravity: "center", crop: "100x130+0+0").processed
  end
end
