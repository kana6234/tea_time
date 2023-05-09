class Shop < ApplicationRecord
  has_many_attached :images
  belongs_to :post, dependent: :destroy
  has_many :business_hours, dependent: :destroy
  has_many :post_tags, through: :post
  has_many :post_comments, through: :post
  accepts_nested_attributes_for :post, :business_hours, allow_destroy: true, update_only: true

  validates :shop_name, presence: true, length: { maximum: 30 }
  validates :website, presence: true, format: /\A#{URI::regexp(%w(http https))}\z/
  validates :postcode, presence: true, length: { is: 7 }
  validates :prefecture_code, presence: true, length: { in: 1..47 }
  validates :address, presence: true, numericality: { only_integer: true }
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


  def get_image(image)
    image.variant(resize: "100x100^", gravity: "center", crop: "100x100+0+0").processed
  end
end
