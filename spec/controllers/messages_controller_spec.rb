require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET /messages' do
    it 'return a list of 20 last messages of a room when it receive a valid id' do
      room = create(:room)

      40.times do |i|
        Message.create(text: "hola #{i}", author: 'nacho', room_id: room.id)
      end

      room_messages = Message.where(room_id: room.id)
                             .order('created_at DESC')
                             .paginate(page: 1, per_page: 20)
                             .reverse

      get :index, params: {id: room.id}

      expect(response.messages).to eq room_messages
    end
  end
end
