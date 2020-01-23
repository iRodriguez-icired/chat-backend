class MessagesController < ApplicationController

    def create
        puts params
        room_id = params[:room_id]
        room = Room.find(room_id)
        30.times do |number|
            Message.create({"text": "#{number}", "author": "Nacho", "room_id": room.id})
        end

    end
end
