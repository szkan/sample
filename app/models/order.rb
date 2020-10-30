class Order < ApplicationRecord
  attr_accessor :token
  
  with_options presence: true do
    validates :token
    validates :phone_number
    validates :email
    validates :post_code
    validates :prefecture_id
    validates :city
    validates :address
  end


  has_one :customer
  belongs_to :product
  belongs_to :user
end
