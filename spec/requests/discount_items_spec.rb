require 'rails_helper'

describe "post an item route", type: :request do
  before do
     post '/api/v1/items', params: { code: 'MUG', name: 'Reedsy Mug', price: '6.00€' }
      post '/api/v1/prices', params: { items: ['MUG'] }
    end
  it 'returns the items' do
      expect(JSON.parse(response.body)['Items']).to eq(['MUG'])
    end
  it 'returns the total' do
      expect(JSON.parse(response.body)['Total']).to eq('6.0€')
    end

  it 'returns a created status' do
      expect(response).to have_http_status(:ok)
    end
end
