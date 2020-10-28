class OrdersController < ApplicationController
  before_action :set_product

  def index
    @buy_form = BuyForm.new
  end

  def create
    @buy_form = BuyForm.new(buy_form_params)
    if @buy_form.valid?
      @buy_form.save
      pay_product
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def buy_form_params
    params.require(:buy_form).permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :email).merge(token: params[:token], user_id: current_user.id, product_id: params[:product_id])
  end

  def pay_product
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @product.price,
      card: buy_form_params[:token],
      currency: 'jpy'
    )
  end

  def set_product
    @product = Product.find(params[:product_id])
  end
end