require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'is valid with valid attributes' do
    user = FactoryBot.create :user
    message = FactoryBot.create(:random_message, :user => user)
    expect(message).to be_valid
  end

  it 'is not valid without a title' do
    message = Message.new(title: nil)
    expect(message).to_not be_valid
  end
end
