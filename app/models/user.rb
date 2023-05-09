class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :question_likes, dependent: :destroy
  has_many :answer_likes, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true
  validates :introduction, length: { maximum: 200 }

  def active_for_authentication?
    super && (is_deleted == false)
  end

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize: "120x120^", gravity: "center", crop: "120x120+0+0").processed
  end

  def already_favorited?(post)
    self.favorites.exists?(post_id: post.id)
  end

  def already_question_liked?(question)
    self.question_likes.exists?(question_id: question.id)
  end

  def already_answer_liked?(answer)
    self.answer_likes.exists?(answer_id: answer.id)
  end

  def already_bookmarked?(question)
    self.bookmarks.exists?(question_id: question.id)
  end

  def self.guest
    find_or_create_by!(email: 'guest@gmail.com') do |user|
      user.name = 'ゲスト'
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now
    end
  end
end
