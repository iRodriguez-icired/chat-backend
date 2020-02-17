class MessagesController < ApplicationController
  def create
    @room = Room.find(message_params['room_id'])
    if @room
      @message = Message.new("text": message_params['text'],
                             "author": message_params['author'],
                             "room_id": @room.id)
      if @message.save
        render json: {message: @message}, status: 201
      else
        render json: {errors: @message.errors.details}, status: 422
      end
    else
      render json: {errors: {'text': [{error: 'not_found'}]}}, status: 404
    end
  end

  def index
    room_id = index_params[:room_id]
    if Room.find(room_id)
      room_messages = Message.paginated_and_reversed(room_id)
      render json: {messages: room_messages}, status: 200
    else
      render json: {errors: {'text': [{error: 'not_found'}]}}, status: 404
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
