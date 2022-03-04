require 'rails_helper'

describe 'post an item route', type: :request do
  before do
    post '/api/v1/items', params: { code: 'MUG', name: 'Reedsy Mug', price: '6.00€' }
  end

  it 'returns the items\'s code' do
    expect(JSON.parse(response.body)['code']).to eq('MUG')
  end

  it 'returns the item\'s name' do
    expect(JSON.parse(response.body)['name']).to eq('Reedsy Mug')
  end

  it 'returns the item\'s price' do
    expect(JSON.parse(response.body)['price']).to eq('6.00€')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:ok)
  end
end
