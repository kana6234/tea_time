class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true

  def create_notification_favorite!(current_user)
    favorite = Notification.where(visitor_id: current_user.id, visited_id: post.user_id, post_id: post_id, action: 'favorite')
    if favorite.blank?
      notification = current_user.active_notifications.new(
        post_id: post_id,
        visited_id: post.user_id,
        action: 'favorite'
      )
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end
end
