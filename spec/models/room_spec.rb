require 'rails_helper'

RSpec.describe Room, type: :model do
  
  it "no name should be invalid" do
    @room = Room.new(name: "")
    expect(@room.valid?).to eq false
  end
  
  it "name must be unique" do
    @savedRoom = create(:room)
    @room = Room.new(name: @savedRoom.name)
    expect(@room.valid?).to eq false
  end
end
