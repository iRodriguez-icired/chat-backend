class RoomsController < ApplicationController
  def index
    rooms = Room.all
    render json: {'rooms' => rooms}, status: 200
  end

  def create
    room = Room.new(create_params)
    if room.save
      render json: {room: room}, status: 201
    else
      render_error_from_details(room.errors.details, 422)
    end
  end

  private

  def create_params
    params.permit(:name)
  end
end
