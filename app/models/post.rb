class Post < ApplicationRecord
  has_one_attached :thumbnail_image
  belongs_to :user
  has_one :recipe, dependent: :destroy
  has_one :shop, dependent: :destroy
  has_one :item, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :catchphrase, presence: true
  validates :introduction, presence: true
  validates :thumbnail_image, presence: true

  def save_tags(sent_tag_names)
    current_tag_names = self.tags.pluck(:name)
    new_tag_names = sent_tag_names - current_tag_names
    if self.post_tags.present?
      old_tag_names = current_tag_names - sent_tag_names
      old_tag_names.each do |old_tag_name|
        old_tag = Tag.find_by(name: old_tag_name)
        old_post_tag = self.post_tags.find_by(tag_id: old_tag.id)
        old_post_tag.destroy
      end
    end
    new_tag_names.each do |new_tag_name|
      new_tag = Tag.find_or_create_by(name: new_tag_name)
      PostTag.create!(post_id: self.id, tag_id: new_tag.id)
    end
  end

  def get_thumbnail_image(width, height)
    thumbnail_image.variant(resize_to_limit: [width, height]).processed
  end
end
