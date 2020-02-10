class MessagesController < ApplicationController
  include MessagesConcern
  def create
    @room = Room.find(message_params['room_id'])
    if @room
      @message = Message.new("text": message_params['text'],
                             "author": message_params['author'],
                             "room_id": @room.id)
      if @message.save
        render json: {message: @message}, status: 201
      else
        render json: {message: I18n.t('message_params_must_be_present')}, status: 422
      end
    else
      render json: {message: I18n.t('room_doesnt_exist')}, status: 404
    end
  end

  def index
    room_id = index_params[:room_id]
    if Room.find(room_id)
      room_messages = order_messages Message.where(room_id: room_id)
      render json: {messages: room_messages}, status: 200
    else
      render json: {message: I18n.t('room_doesnt_exist')}, status: 404
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :author, :room_id)
  end

  def index_params
    params.permit(:room_id)
  end
end
