class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:merchant_id])
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    else
      render json: {errors: {details: "A merchant with this id does not exist"}}, status: 404
    end
  end
end