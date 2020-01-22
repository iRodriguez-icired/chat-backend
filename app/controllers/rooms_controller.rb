class RoomsController < ApplicationController
  
  def index
    rooms = Room.all
    render json: {'rooms' => rooms}, status: 201
  end
  
  def create
    @room = Room.create(name: params[:name])
    if @room
      render json: {room: @room}, status: 201
    end
    
  end
end
