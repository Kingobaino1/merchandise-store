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
    mug_discount = 0
    tshirt_discount = 0
    zero_discount = 0
    currency = ''
    query_params['items'].each do |item|
      item_price = Item.find_by(code: item)
      currency = item_price.price[-1]
      count = query_params['items'].count(item)
      if item_price.code == 'MUG' && count >= 2
        mug_count = query_params['items'].count(item)  - 1
        mug_discount = mug_count * item_price.price.to_f
      elsif (item_price.code == 'TSHIRT' && count >= 3)
        tshirt_discount = 0.7 * item_price.price.to_f * count
      else
        zero_discount += item_price.price.to_f
      end
    end
    total = mug_discount + tshirt_discount + zero_discount
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
