class MessagesController < ApplicationController
  def create
    @room_id = Room.find(message_params['room_id']).id
    @message = Message.create("text": message_params['text'],
                              "author": message_params['author'],
                              "room_id": @room_id)
    render json: {message: @message}, status: 201
  end

  def index
    room_id = index_params[:room_id]
    room_messages = Message.where(room_id: room_id)
                           .order('created_at DESC')
                           .paginate(page: 1, per_page: 20)
                           .reverse
    render json: {messages: room_messages}, status: 200
  end

  private

  def message_params
    params.require(:message).permit(:text, :author, :room_id)
  end

  def index_params
    params.permit(:room_id)
  end
end
