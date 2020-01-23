class MessagesController < ApplicationController

    def create
        @room_id = Room.find(params[:message][:room_id]).id
        @message = Message.create("text": params[:message][:text], "author": params[:message][:author], "room_id": @room_id)
        if @message.save
            ActionCable.server.broadcast "room_channel", content: @message
        else

        end

    end
end
