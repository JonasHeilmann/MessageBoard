require 'rails_helper'

RSpec.describe 'GET messages', :type => :request do 
  let!(:messages) { FactoryBot.create_list(:random_message, 20) }
  let(:headers) { { 'ACCEPT' => 'application/json' } }

  describe 'GET all messages' do
    before {
      get '/messages', :headers => headers
    }

    it 'returns all messages' do
      expect(JSON.parse(response.body).size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET a messages' do
    before {
      get "/messages/#{messages[0].id}", :headers => headers
    }

    it 'returns the message' do
      pp JSON.parse(response.body)
      expect(JSON.parse(response.body)['title']).to eq(messages[0].title)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET a messages that does not exists' do
    before {
      get "/messages/21", :headers => headers
    }

    it 'returns no message' do
      expect(JSON.parse(response.body)['error']).to match("Couldn't find Message with 'id'=21")
    end

    it 'returns status code 404' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
