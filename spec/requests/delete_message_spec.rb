require 'rails_helper'

RSpec.describe "DELETE a message", :type => :request do 
  before do
    user1 = FactoryBot.create :user
    user2 = FactoryBot.create :user

    @headers = { 
      'ACCEPT' => 'application/json', 
      'X-User-Email' => user1.email,
      'X-User-Token' => user1.authentication_token 
    }
    @message_one = FactoryBot.create(:random_message, :user => user1)
    @message_two = FactoryBot.create(:random_message, :user => user1)
    @message_three = FactoryBot.create(:random_message, :user => user2)
  end

  it 'should get the messages, delete the first one and should end up with only the last two ones' do
    get "/messages", :headers => @headers
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to eq([
      YAML.load(@message_three.to_json),
      YAML.load(@message_two.to_json),
      YAML.load(@message_one.to_json) 
    ])

    delete "/messages/#{@message_one.id}", :headers => @headers
    expect(response).to have_http_status(:no_content)
  
    get "/messages", :headers => @headers
    expect(JSON.parse(response.body)).to eq([
      YAML.load(@message_three.to_json),
      YAML.load(@message_two.to_json)
    ])
  end

  it 'should not allow user1 to delete the message of user 2' do
    get "/messages", :headers => @headers
    expect(response).to have_http_status(:ok)
    expect(JSON.parse(response.body)).to eq([
      YAML.load(@message_three.to_json),
      YAML.load(@message_two.to_json),
      YAML.load(@message_one.to_json) 
    ])

    delete "/messages/#{@message_three.id}", :headers => @headers
    expect(response).to have_http_status(:unauthorized)
  end
end