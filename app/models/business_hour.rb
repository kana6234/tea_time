class BusinessHour < ApplicationRecord
  belongs_to :shop, optional: true

  validates :start_at, presence: true
  validates :finish_at, presence: true
  validate :start_finish_check

  def start_finish_check
    errors.add(:finish_at, "は開始時刻より遅い時間を選択してください") if self.start_at > self.finish_at
  end
end
