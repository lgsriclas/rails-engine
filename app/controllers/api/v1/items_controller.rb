class Api::V1::ItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end

  def find_item
    @item = Item.find(params[:id])
  end

  def show
    if Item.exists?(params[:id])
      render json: ItemSerializer.new(Item.find(params[:id]))
    else
      render json: ItemSerializer.item_not_found, status: 404
    end
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: 200
    else
      render json: ItemSerializer.not_created, status: 404
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.delete
      render json: item.delete, status: 200
    else
      render status: 404
    end
  end

  def update
    # item = Item.find(params[:id])
    # if item.update(item_params)
    #   render json: ItemSerializer.new(Item.update(params[:id], item_params))
    # else
    #   render json: ItemSerializer.not_updated, status: 404
    # end
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(@item).serializable_hash, status: :ok
    else
      render json: ItemSerializer.not_updated, status: 404
    end
    #
    # if Item.exists?(params[:id])
    #   render json: ItemSerializer.new(Item.update(item_params))
    # else
    #   render json: ItemSerializer.not_updated, status: 404
    # end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end