class QuestionTag < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  MAX_QUESTION_TAGS_COUNT = 10
  validates :question_id, presence: true
  validates :tag_id, presence: true
  validate :question_tags_count_must_be_within_limit

  private

  def question_tags_count_must_be_within_limit
    errors.add(:base, "question_tags count limit: #{MAX_QUESTION_TAGS_COUNT}") if question.question_tags.count >= MAX_QUESTION_TAGS_COUNT
  end
end
