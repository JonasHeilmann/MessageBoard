require 'rails_helper'

RSpec.describe "GET all messages", :type => :request do 
  let!(:messages) { FactoryBot.create_list(:random_message, 20) }
  headers = { 'ACCEPT' => 'application/json' }

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