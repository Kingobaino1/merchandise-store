require 'rails_helper'

describe 'update an item\'s route' do
  before do
    @item = Item.create(code: 'MUG', name: 'Reedsy Mug', price: '6.00€')
  end
  it 'updates an item\'s price' do
    @new_price = '5.00$'
    put "/api/v1/items/#{@item.id}", params: { price: @new_price }
    expect(response.status).to eq(200)
    expect(Item.find(@item.id).price).to eq(@new_price)
  end
end
