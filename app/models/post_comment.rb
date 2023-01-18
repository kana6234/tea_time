class PostComment < ApplicationRecord
  has_one_attached :comment_image
  belongs_to :user
  belongs_to :post
  has_many :notification, dependent: :destroy

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :comment, presence: true

  def create_notification_post_comment!(current_user)
    notification = current_user.active_notifications.new(
      post_id: post_id,
      post_comment_id: id,
      visited_id: post.user_id,
      action: 'post_comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end

  def get_comment_image(width, height)
    comment_image.variant(resize_to_limit: [width, height]).processed
  end
end
