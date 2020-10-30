class CardsController < ApplicationController

  def new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
    description: 'test',
    card: params[:card_token]
    )
    card = Card.new(
    card_token: params[:card_token],
    customer_token: customer.id,
    user_id: current_user.id
    )
    if card.save
      redirect_to mypage_path
    else
      redirect_to "new"
    end
  end

  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
 
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  def destroy
    if @card.destroy
      redirect_to "show"
    else
      render :show
    end
  end

end
