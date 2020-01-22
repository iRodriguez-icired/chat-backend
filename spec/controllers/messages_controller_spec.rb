require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
    describe "GET /messages" do
        it "returns a 200 status and 20 messages of the room when request is valid" do
            @room = create(:room)
            @params = { id: @room.id}
            25.times do |num|
                @message = Message.new ({text: "mensaje #{num}", author: "Nacho", room_id: @room.id})
                @message.save
            end
            @messages = Message.where(room_id: @room.id).to_a
            @messages.sort_by {|message| message.created_at}
            @messages = @messages.reverse.take(20)
            #puts @messages.created_at
            get :show, params: @params
            expect(response).to have_http_status(200)
            JSONResponse = JSON.parse response.body
            expect(JSONResponse["messages"]).to eq @messages
        end
        
        it "returns a 404 status and a message if room is not found" do
            @room = build(:room)
            @params = { id: @room.id }

            get :show, params: @params
            expect(response).to have_http_status(404)
        end
    end
end
