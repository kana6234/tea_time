class Shop < ApplicationRecord
  has_many_attached :images
  has_one :post, as: :postable, dependent: :destroy
  has_many :business_hours, dependent: :destroy
  has_many :post_tags, through: :post
  accepts_nested_attributes_for :post, :business_hours, allow_destroy: true, update_only: true

  validates :shop_name, presence: true
  validates :postcode, presence: true
  validates :prefecture_code, presence: true
  validates :address, presence: true
  validates :post, presence: true
  validates :business_hours, presence: true

  #geocoderの適用
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  #jp_prefectureの記述

  #都道府県コードから都道府県名に自動で変換
  include JpPrefecture
  jp_prefecture :prefecture_code

  #都道府県名を参照
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
end
