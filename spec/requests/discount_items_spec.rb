require 'rails_helper'

describe 'post an item route', type: :request do
  before(:each) do
    post '/api/v1/items', params: { code: 'MUG', name: 'Reedsy Mug', price: '6.00€' }
    post '/api/v1/items', params: { code: 'TSHIRT', name: 'Reedsy T-shirts', price: '15.00€' }
    post '/api/v1/items', params: { code: 'HOODIE', name: 'Reedsy hoodie', price: '20.00€' }
    post '/api/v1/prices', params: { items: ['MUG', 'TSHIRT', 'HOODIE'] }
  end

  it 'returns selected items' do
    expect(JSON.parse(response.body)['Items']).to eq(['MUG', 'TSHIRT', 'HOODIE'])
  end

  it 'returns the total' do
    expect(JSON.parse(response.body)['Total']).to eq('41.0€')
  end

  it 'returns the total for 2-in-1 discount' do
    post '/api/v1/prices', params: { items: ['MUG', 'TSHIRT', 'MUG', 'MUG'] }
    expect(JSON.parse(response.body)['Total']).to eq('27.0€')
  end

  it 'returns the total for 30% discount' do
    post '/api/v1/prices', params: { items: ['TSHIRT', 'TSHIRT', 'TSHIRT', 'TSHIRT'] }
    expect(JSON.parse(response.body)['Total']).to eq('42.0€')
  end

  it 'returns the total for combinned discount' do
    post '/api/v1/prices', params: { items: ['MUG', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'TSHIRT', 'MUG', 'HOODIE'] }
    expect(JSON.parse(response.body)['Total']).to eq('68.0€')
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:ok)
  end
end
