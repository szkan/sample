class Product < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image

  validates :title, presence: true
  validates :price, presence: true, numericality: { only_integer: true }
  validates :image, presence: true
end
