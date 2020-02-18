require 'rails_helper'
require 'faker'

RSpec.describe MessagesController, type: :controller do
  describe 'GET /messages' do
    it 'return a list of 20 last messages id is valid and get a 200 code' do
      room = create(:room)
      create_list(:message, 40, text: Faker::Lorem.sentence,
                                author: Faker::Name.first_name,
                                room_id: room.id)

      room_messages = Message.paginated_and_reversed(room.id)

      get :index, params: {room_id: room.id}
      json_response = JSON.parse response.body

      response_ids = []
      json_response['messages'].each do |message|
        response_ids.push(message['_id'])
      end

      room_messages_ids = []
      room_messages.each do |message|
        room_messages_ids.push(message['_id'].as_json)
      end

      expect(response_ids).to eq room_messages_ids
      expect(response).to have_http_status(200)
    end

    it "return a 404 message error and a message if room doesn't exist" do
      room_id = 1234

      get :index, params: {room_id: room_id}
      json_response = JSON.parse response.body

      expect(response).to have_http_status(404)
      expect(json_response['errors']).not_to eq(nil)
    end
  end

  describe 'POST /messages' do
    it 'create a new message into database and receive a 201 status code' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: 'nacho', author: 'nacho'}
      json_response = JSON.parse response.body
      generated_message_id = json_response['message']['_id']

      db_message = Message.find(generated_message_id)
      expect(db_message).not_to eq nil
      expect(response).to have_http_status(201)
    end

    it 'returns a 404 code if message.room_id doesnt belong to an existent room' do
      room_id = 1234
      post :create, params: {room_id: room_id, text: 'nacho', author: 'nacho'}
      json_response = JSON.parse response.body

      expect(response).to have_http_status(404)
      expect(json_response['errors']).not_to eq(nil)
    end

    it 'returns a 422 code and a message if text is blank' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: '', author: 'nacho'}
      json_response = JSON.parse response.body

      expect(response).to have_http_status(422)
      expect(json_response['errors']).not_to eq(nil)
    end

    it 'returns a 422 code and a message if author is blank' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: 'hola', author: ''}
      json_response = JSON.parse response.body

      expect(response).to have_http_status(422)
      expect(json_response['errors']).not_to eq(nil)
    end
  end
end
