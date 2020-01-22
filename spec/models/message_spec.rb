require 'rails_helper'

RSpec.describe Message, type: :model do
  
  before :each do
    @room = Room.create(name: "sala-test");
    @message = create(:message, room_id: @room)
  end
  
  it "should be invalid if the text is blank" do
    @message.text = ""
    expect(@message.valid?).to eq false
  end
  
  it "should be invalid if doesn't have an author" do
    @message.author = ""
    expect(@message.valid?).to eq false
    
  end
  
  it "should be invalid if doesn't belong to an existent room" do
    @message.room_id = nil
    expect(@message.valid?).to eq false
  end
  
  it "should be invalid if exceed 140 characters limit" do
    @message.text = 'a' * 141
    expect(@message.valid?).to eq false
  end
end
