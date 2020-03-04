require 'rails_helper'

RSpec.describe RoomsController, type: :controller do
  describe 'GET /rooms' do
    it 'returns a 201 status code and show an empty array when database is clear' do
      get :index
      expect(response).to have_http_status(200)
      json_parsed = parse_response(response)
      expect(json_parsed['rooms']).to be_empty
    end

    it 'returns a 201 status code and a list of results when database has entries' do
      Room.create(name: 'Room')
      get :index
      expect(response).to have_http_status(200)
      json_parsed = parse_response(response)
      expect(json_parsed['rooms']).not_to be_empty
    end
  end

  describe 'POST /room' do
    it 'returns a 201 status code, creates the room and return it if room is valid' do
      params = {"name": 'Sala 1'}
      post :create, params: params
      expect(response).to have_http_status(201)
      json_parsed = parse_response(response)
      expect(json_parsed['room']['name']).to eq(params[:name])
      dbroom = Room.find_by(name: json_parsed['room']['name'])
      expect(dbroom).not_to eq nil
    end

    it 'returns a 422 status code if room creation fails and show a message error' do
      params = {"name": ''}
      post :create, params: params
      expect(response).to have_http_status(422)

      json_parsed = parse_response(response)
      expect(json_parsed['errors']).not_to eq(nil)
    end

    it 'returns a 422 status code if room name is not unique' do
      room = Room.create(name: 'SALA')
      params = {"name": room.name}
      post :create, params: params
      expect(response).to have_http_status(422)

      json_parsed = parse_response(response)
      expect(json_parsed['errors']).not_to eq(nil)
    end
  end
end
