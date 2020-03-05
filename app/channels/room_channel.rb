class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_#{room.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def room
    @room = Room.find(params[:id])
  end

  def receive(data)
    params = {text: data['content']['text'], 
              author: data['content']['author'],
              room_id: Room.find(data['content']['room_id']).id}
    message = Message.new(params)
    return unless message.save

    ActionCable.server.broadcast "room_#{room.id}",
                                 message: message
  end
end
