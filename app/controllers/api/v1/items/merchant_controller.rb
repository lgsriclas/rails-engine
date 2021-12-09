class Api::V1::Items::MerchantController < ApplicationController
  def index
    if Item.exists?(params[:item_id])
      render json: MerchantSerializer.new(Item.find(params[:item_id]).merchant)
    else
      render json: {errors: {details: "A merchant with this id does not exist"}}, status: 404
    end
  end
end