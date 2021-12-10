class Api::V1::ItemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: {errors: {details: "An item with this id does not exist"}}, status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 201
    else
      render json: {errors: {details: "Item not created."}}, status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.delete
    render json: item.delete, status: 204
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item).serializable_hash, status: 200
    else
      render json: {errors: {details: "Item not updated."}}, status: 404
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end