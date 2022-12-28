class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags

  validates :content, presence: true

  def save_tags(sent_tag_names)
    current_tag_names = self.tags.pluck(:name)
    new_tag_names = sent_tag_names - current_tag_names
    new_tag_names.each do |new_tag_name|
      new_tag = Tag.find_or_create_by(name: new_tag_name)
      QuestionTag.create!(question_id: self.id, tag_id: new_tag.id)
    end
  end
end
