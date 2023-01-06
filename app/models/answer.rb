class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :answer_likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true

  def create_notification_answer!(current_user)
    notification = current_user.active_notifications.new(
      question_id: question_id,
      answer_id: id,
      visited_id: question.user_id,
      action: 'answer'
    )
    if notification.visitor_id == notification.visited_id
      notification.is_checked = true
    end
    notification.save if notification.valid?
  end
end
