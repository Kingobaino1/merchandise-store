class Api::V1::ItemsController < ApplicationController
  def index
    @items = Item.all
    render json: @items
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render json: @item
    else
      render json: 'Item not created'
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(price_params)
      render json: @item
    else
      render json: 'Item not updated'
    end
  end

  def price
    total = 0
    currency = ''
    query_params['items'].each do |item|
      item_price = Item.find_by(code: item)
      total += item_price.price.to_f
      currency = item_price.price[-1]
    end
    sum = total.to_s + currency
    render json: { Items: query_params['items'], Total: sum }
  end 

  private

  def item_params
    params.permit(:code, :name, :price)
  end

  def price_params
    params.permit(:price)
  end

  def query_params
    params.permit(items: [])
  end
end
