class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :answer_likes, dependent: :destroy

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :content, presence: true
end
