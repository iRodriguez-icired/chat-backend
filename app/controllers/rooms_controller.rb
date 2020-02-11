class RoomsController < ApplicationController
  def index
    rooms = Room.all
    render json: {'rooms' => rooms}, status: 200
  end

  def create
    @room = Room.new(name: create_params[:name])
    uniqueness = Room.find_by(name: @room.name).nil?
    if @room.save
      render json: {room: @room}, status: 201
    elsif uniqueness
      render json: {message: I18n.t('room_creation_failed')}, status: 422
    else
      render json: {message: I18n.t('room_creation_failed_not_unique')}, status: 422
    end
  end

  private

  def create_params
    params.permit(:name)
  end
end
