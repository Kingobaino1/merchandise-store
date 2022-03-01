class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all
    render json: @items
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: { item: @item, status: 'created'}
    else
      render json: { error: 'Item not created' }
    end
  end

  private

  def item_params
    params.permit(:code, :name, :price)
  end
end
