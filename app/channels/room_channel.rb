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
    data = JSON.parse(data).to_json
    text = data['text']
    author = data['author']
    room_id = Room.find(data['room_id']).id
    @message = Message.create(text: text, author: author, room_id: room_id)
    ActionCable.server.broadcast "room_#{room.id}",
                                 message: @message
  end
end
