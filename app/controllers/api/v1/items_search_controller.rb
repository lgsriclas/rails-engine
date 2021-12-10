class Api::V1::ItemsSearchController < ApplicationController
  def index
    search = Item.find_all_items(params[:name])
    render json: ItemSerializer.new(search)
  end

  def show
    if params[:name] && params[:min_price]
      render json: {errors: {details: "Cannot search by name and price"}}, status: 400
    elsif params[:name] && params[:max_price]
      render json: {errors: {details: "Cannot search by name and price"}}, status: 400
    elsif params[:name]
      search = Item.find_one_item(params[:name])
      render json: ItemSerializer.new(search)
    elsif params[:max_price]
      search = Item.find_below(params[:max_price])
      render json: ItemSerializer.new(search)
    elsif params[:min_price]
      search = Item.find_one_item(params[:name])
      render json: ItemSerializer.new(search)
    elsif params[:min_price] && params[:max_price]
      search = Item.find_by_price_range(params[:min_price], params[:max_price])
      render json: ItemSerializer.new(search)
    elsif params[:name] && params[:min_price] || params[:max_price]
      render json: {errors: {details: "Cannot search by name and price"}}, status: 400
    elsif params[:name] == ''
      render json: {errors: {details: "Name cannot be blank"}}, status: 400
    elsif params[:min_price] || params[:max_price] < 0
      render json: {errors: {details: "Price cannot be less than 0"}}, status: 400
    end

    # search = Item.find_one_item(params[:name])
    # if search != nil
    #   render json: ItemSerializer.new(search)
    # else
    #   render json: {data: {}}
    # end
  end
end