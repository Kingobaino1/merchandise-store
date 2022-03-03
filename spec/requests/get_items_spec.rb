require 'rails_helper'

RSpec.describe 'get all items route', type: :request do
  let!(:items) {FactoryBot.create_list(:random_item, 20)}
  before {get '/api/v1/items'}
  it 'returns all items' do
      expect(JSON.parse(response.body).size).to eq(20)
    end
  it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end

end
