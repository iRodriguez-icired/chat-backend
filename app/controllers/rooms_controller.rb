class RoomsController < ApplicationController
  
  def index
    rooms = Room.all
    render json: {'rooms' => rooms}, status: 201
  end
  
  def create
    @room = Room.new(name: params[:name])
    if @room.save
      render json: {room: @room}, status: 201
    else
      render json: {message: "La sala no pudo ser creada"}, status: 400
    end
    
  end

  def show
    id = params[:id]
    messages = Message.where(room_id: id).to_a
    messages = messages.reverse.take(20)
    render json: {messages: messages}, status: 200
  end
end
