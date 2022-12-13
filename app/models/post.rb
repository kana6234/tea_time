class Post < ApplicationRecord
  has_one_attached :thumbnail_image
  belongs_to :user
  belongs_to :postable, polymorphic: true, optional: true
  has_many :post_tags, dependent: :destroy

  validates :user_id, presence: true
  validates :postable_type, presence: true
  validates :title, presence: true
  validates :catchphrase, presence: true
  validates :introduction, presence: true
  validates :thumbnail_image, presence: true
end
