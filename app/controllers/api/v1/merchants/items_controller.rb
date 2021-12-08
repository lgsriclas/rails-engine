class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    if Merchant.exists?(params[:merchant_id])
      render json: ItemSerializer.new(Merchant.find(params[:merchant_id]).items)
    else
      render json: MerchantSerializer.merchant_not_found, status: 404
    end
  end
end