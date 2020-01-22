class RoomsController < ApplicationController
  
  def showRooms
    rooms = Room.all
    render json: {rooms: rooms}, status: 201
  end
end
