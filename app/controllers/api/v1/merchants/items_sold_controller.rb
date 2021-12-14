class Api::V1::Merchants::ItemsSoldController < ApplicationController
  def index
    number = params[:quantity]
    merchants = Merchant.most_items_sold(number)
    render json: ::MerchantItemsSoldSerializer.new(merchants).serializable_hash.to_json
  end
end