class MessagesController < ApplicationController
  def create
    if Room.find(create_params['room_id'])
      message = Message.new(create_params)
      if message.save
        render json: {message: message}, status: 201
      else
        render json: {errors: message.errors.details}, status: 422
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

  def create_params
    params.permit(:text, :author, :room_id)
  end

  def index_params
    params.permit(:room_id)
  end
end
