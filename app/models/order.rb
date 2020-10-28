class Order < ApplicationRecord
  has_one :customer
  belongs_to :product
  belongs_to :user
end
