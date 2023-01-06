class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  enum action: { favorite: 0, post_comment: 1, question_like: 2, answer: 3, answer_like: 4, bookmark: 5 }
  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id'
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id'
  belongs_to :post, optional: true
  belongs_to :post_comment, optional: true
  belongs_to :question, optional: true
  belongs_to :answer, optional: true
end
