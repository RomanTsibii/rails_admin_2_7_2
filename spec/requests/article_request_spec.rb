require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/en/articles#index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/en/articles#show'
      expect(response).to have_http_status(:success)
    end
  end
end
