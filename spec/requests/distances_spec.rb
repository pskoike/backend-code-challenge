require 'rails_helper'

RSpec.describe 'Distance API', type: :request do
  describe 'POST /distance' do
    before { post "/distance?distance=#{params}" }

    context 'when params are valid' do
      let(:params) { 'A B 10' }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when params are not valid' do
      let(:params) { 'A B X' }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /cost' do
    before {create_list(:distance, 50)}
    before {create(:distance, origin: origin, destination: destination)}
    before { get "/cost?origin=#{origin}&destination=#{destination}&weight=#{weight}" }


    context 'when params are valid' do
      let(:origin) { 'A' }
      let(:destination) { 'C' }
      let(:weight) { 5 }
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
        expect(response.body).to match(/7.5/)
      end
    end

    context 'when params are not valid' do
      let(:origin) { 'A' }
      let(:destination) { 'C' }
      let(:weight) { 54 }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end
end
