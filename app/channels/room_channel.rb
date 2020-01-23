class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from room
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def room
    Room.find(params[:id])
  end

  def receive(data)
      text = data["content"]["text"]
      author = data["content"]["author"]
      room_id = Room.find(data["content"]["room_id"]).id
      Message.create(text: text, author: author, room_id: room_id)
  end
end
