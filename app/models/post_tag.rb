class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  MAX_POST_TAGS_COUNT = 10
  validates :post_id, presence: true
  validates :tag_id, presence: true
  validate :post_tags_count_must_be_within_limit

  private

  def post_tags_count_must_be_within_limit
    errors.add(:base, "post_tags count limit: #{MAX_POST_TAGS_COUNT}") if post.post_tags.count >= MAX_POST_TAGS_COUNT
  end
end
