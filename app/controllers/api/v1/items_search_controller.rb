class Api::V1::ItemsSearchController < ApplicationController
  def index
    search = Item.find_all_items(params[:name])
    render json: ItemSerializer.new(search)
  end

  def show
    search = Item.find_one_item(params[:name])
    render json: ItemSerializer.new(search)
  end
end