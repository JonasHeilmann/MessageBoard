require 'rails_helper'

RSpec.describe "PUT /messages/:id", :type => :request do  
  before do 
    user1 = FactoryBot.create :user
    user2 = FactoryBot.create :user

    @headers = { 
      'ACCEPT' => 'application/json', 
      'X-User-Email' => user1.email,
      'X-User-Token' => user1.authentication_token 
    }

    @message1 = FactoryBot.create(:random_message, :user => user1)
    @message2 = FactoryBot.create(:random_message, :user => user2)

    @new_title = Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4)
    @new_description = Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)

    put "/messages/#{@message1.id}", :params => {
      :message => { 
        :title => @new_title, 
        :description => @new_description 
      }
    }, :headers => @headers
  end

  it 'returns and updates the message\'s title' do
    expect(JSON.parse(response.body)['message']['title']).to eq(@new_title)  
    expect(Message.find(@message1.id).title).to eq(@new_title)
  end
  
  it 'returns and updates the message\'s description' do
    expect(JSON.parse(response.body)['message']['description']).to eq(@new_description)
    expect(Message.find(@message1.id).description).to eq(@new_description)
  end

  it 'returns a accepted status' do
    expect(response).to have_http_status(:accepted)
  end

  it 'should not allow user1 to edit the message of user2' do
    put "/messages/#{@message2.id}", :params => {
      :message => { 
        :title => @new_title, 
        :description => @new_description
      }
    }, :headers => @headers
    expect(response).to have_http_status(:unauthorized)
  end
end