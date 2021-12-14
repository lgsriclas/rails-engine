class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    number = params[:quantity]
    items = Item.top_items_by_revenue(number)
    render json: ::ItemNameRevenueSerializer.new(items).serializable_hash.to_json
  end
end