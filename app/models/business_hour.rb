class BusinessHour < ApplicationRecord
  belongs_to :shop, optional: true

  validates :start_at, presence: true
  validates :finish_at, presence: true
end
