require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  describe 'GET /messages' do
    it 'return a list of 20 last messages of a room when it receive a valid id and get a 200 code' do
      room = create(:room)

      40.times do |i|
        Message.create(text: "hola #{i}", author: 'nacho', room_id: room.id)
      end

      room_messages = Message.where(room_id: room.id)
                             .order('created_at DESC')
                             .paginate(page: 1, per_page: 20)
                             .reverse

      get :index, params: {room_id: room.id}
      JSON_response = JSON.parse response.body

      response_ids = []
      JSON_response['messages'].each do |message|
        response_ids.push(message['_id'])
      end

      room_messages_ids = []
      room_messages.each do |message|
        room_messages_ids.push(message['_id'].as_json)
      end

      expect(response_ids).to eq room_messages_ids
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /messages' do
    it 'create a new message into database and receive a 201 status code' do
      room_id = create(:room).id
      post :create, params: {message: {room_id: room_id, text: 'nacho', author: 'nacho'}}
      JSON_response = JSON.parse response.body
      generated_message_id = JSON_response['message']['_id']

      db_message = Message.find(generated_message_id)
      expect(db_message).not_to eq nil
      expect(response).to have_http_status(201)
    end
  end
end
