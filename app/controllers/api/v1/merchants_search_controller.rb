class Api::V1::MerchantsSearchController < ApplicationController
  def index
    search = Merchant.find_all_merchants(params[:name])
    render json: MerchantSerializer.new(search)
  end

  def show
    search = Merchant.find_one_merchant(params[:name])
    if search != nil
      render json: MerchantSerializer.new(search)
    else
      render json: {data: {}}
    end
  end
end