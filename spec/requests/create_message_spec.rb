require 'rails_helper'

RSpec.describe "POST a new message", :type => :request do
  title = 'Message title'
  description = 'A description of the message'

  before do
    @user = FactoryBot.create :user
    headers = { 
      'ACCEPT' => 'application/json', 
      'X-User-Email' => @user.email,
      'X-User-Token' => @user.authentication_token 
    }
    post '/messages', :params => { 
      :message => {
        :title => title, 
        :description => description
      } 
    }, :headers => headers
  end
  
  it 'returns the message\'s title' do
    expect(JSON.parse(response.body)['message']['title']).to eq(title)  
  end
  
  it 'returns the message\'s description' do
    expect(JSON.parse(response.body)['message']['description']).to eq(description)
  end

  it 'returns the message\'s owner\'s id' do
    expect(JSON.parse(response.body)['message']['user_id']).to eq(@user.id)
  end

  it 'returns a created status' do
    expect(response).to have_http_status(:created)
  end
end