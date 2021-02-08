require 'rails_helper'

describe ArticlesController do
  describe '#index' do
    subject { get :index }
    it 'should return success response' do
      subject

      expect(response).to have_http_status(:ok)
    end
  end
end
