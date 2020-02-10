class RoomsController < ApplicationController
  def index
    rooms = Room.all
    render json: {'rooms' => rooms}, status: 200
  end

  def create
    @room = Room.new(name: create_params[:name])
    if @room.save
      render json: {room: @room}, status: 201
    else
      render json: {message: I18n.t('room_creation_failed')}, status: 422
    end
  end

  private

  def create_params
    params.permit(:name)
  end
end
