class BuyForm
  include ActiveModel::Model
  attr_accessor :token, :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :product_id, :user_id, :email

  with_options presence: true do
    validates :token
    validates :phone_number
    validates :email
    validates :post_code
    validates :prefecture_id
    validates :city
    validates :address
  end

  def save
    order = Order.create(user_id: user_id, product_id: product_id)
    Customer.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, order_id: order.id, email: email)
  end
end
