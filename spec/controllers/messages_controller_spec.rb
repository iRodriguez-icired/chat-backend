require 'rails_helper'
require 'faker'

RSpec.describe MessagesController, type: :controller do
  describe 'GET /messages' do
    it 'return a list of 20 last messages if is valid and get a 200 code' do
      room = create(:room)
      create_list(:message, 40, room_id: room.id)
      room_messages = Message.paginated_and_reversed(room.id, nil, nil, 'created_at DESC')

      get :index, params: {room_id: room.id, sort: 'created_at'}
      json_parsed = parse_response(response)

      json_parsed['messages'] = json_parsed['messages'].map do |message|
        message['_id']
      end

      room_messages = room_messages.map do |message|
        message['_id'].as_json
      end

      expect(json_parsed['messages']).to eq room_messages
      expect(response).to have_http_status(200)
    end

    it "return a 404 message error and a message if room doesn't exist" do
      room_id = 1234

      get :index, params: {room_id: room_id}
      json_parsed = parse_response(response)

      expect(response).to have_http_status(404)
      expect(json_parsed['errors']).not_to eq(nil)
    end
  end

  describe 'POST /messages' do
    it 'create a new message into database and receive a 201 status code' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: 'nacho', author: 'nacho'}
      json_parsed = parse_response(response)
      generated_message_id = json_parsed['message']['_id']

      db_message = Message.find(generated_message_id)
      expect(db_message).not_to eq nil
      expect(response).to have_http_status(201)
    end

    it 'returns a 404 code if message.room_id doesnt belong to an existent room' do
      room_id = 1234
      post :create, params: {room_id: room_id, text: 'nacho', author: 'nacho'}
      json_parsed = parse_response(response)

      expect(response).to have_http_status(404)
      expect(json_parsed['errors']).not_to eq(nil)
    end

    it 'returns a 422 code and a message if text is blank' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: '', author: 'nacho'}
      json_parsed = parse_response(response)

      expect(response).to have_http_status(422)
      expect(json_parsed['errors']).not_to eq(nil)
    end

    it 'returns a 422 code and a message if author is blank' do
      room_id = create(:room).id
      post :create, params: {room_id: room_id, text: 'hola', author: ''}
      json_parsed = parse_response(response)

      expect(response).to have_http_status(422)
      expect(json_parsed['errors']).not_to eq(nil)
    end
  end
end
