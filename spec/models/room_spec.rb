require 'rails_helper'

RSpec.describe Room, type: :model do
  it 'no name should be invalid' do
    @room = Room.new(name: '')
    expect(@room.valid?).to eq false
  end

  it 'name must be unique' do
    @saved_room = create(:room)
    @room = Room.new(name: @saved_room.name)
    expect(@room.valid?).to eq false
  end

  it 'if name is valid and unique, room is valid' do
    @room = Room.new(name: 'Sala 1')
    expect(@room.valid?).to eq true
  end
end
