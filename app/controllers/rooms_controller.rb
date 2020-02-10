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

  def show
    id = show_params[:id]
    messages = Message.where(room_id: id).to_a
    messages = messages.reverse.take(20)
    render json: {messages: messages}, status: 200
  end

  private

  def show_params
    params.permit(:id)
  end

  def create_params
    params.permit(:name)
  end
end
