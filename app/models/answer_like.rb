class AnswerLike < ApplicationRecord
  belongs_to :user
  belongs_to :answer

  validates :user_id, presence: true
  validates :answer_id, presence: true

  def create_notification_answer_like!(current_user)
    answer_like = Notification.where(visitor_id: current_user.id, visited_id: answer.user_id, answer_id: answer_id, action: 'answer_like')
    if answer_like.blank?
      notification = current_user.active_notifications.new(
        answer_id: answer_id,
        visited_id: answer.user_id,
        action: 'answer_like'
      )
      if notification.visitor_id == notification.visited_id
        notification.is_checked = true
      end
      notification.save if notification.valid?
    end
  end
end
