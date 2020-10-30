class OrdersController < ApplicationController
  before_action :set_product

  def index
    @order = Order.new
    if user_signed_in? && current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: current_user.id)

      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def create
    if user_signed_in? && current_user.card.present?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      card = Card.find_by(user_id: current_user.id)

      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end

    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      pay_product
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :email).merge(token: params[:token], product_id: params[:product_id])
  end

  def pay_product
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end