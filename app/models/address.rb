class Address < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :post_code
    validates :prefecture_id
    validates :city
    validates :address
  end
end
