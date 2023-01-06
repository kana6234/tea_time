class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :user_id, presence: true
  validates :question_id, presence: true

  def create_notification_bookmark!(current_user)
    bookmark = Notification.where(visitor_id: current_user.id, visited_id: question.user_id, question_id: question_id, action: 'bookmark')
    if bookmark.blank?
      notification = current_user.active_notifications.new(
        question_id: question_id,
        visited_id: question.user_id,
        action: 'bookmark'
      )
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end
end
