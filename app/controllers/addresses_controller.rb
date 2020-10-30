class AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update]
  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end


  private
  def address_params
    params.require(:address).permit(:post_code, :prefecture_id, :city, :address, :building_name)
  end
  def set_address
    @address = Address.find(params[:id])
  end
end
