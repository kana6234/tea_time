class Post < ApplicationRecord
  has_one_attached :thumbnail_image
  belongs_to :user
  belongs_to :postable, polymorphic: true, optional: true
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :postable_type, presence: true
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

  class << self
    def seach_recipe
      self.where(postable_type: "Recipe")
    end

    def seach_shop
      self.where(postable_type: "Shop")
    end

    def seach_item
      self.where(postable_type: "Item")
    end
  end
end
