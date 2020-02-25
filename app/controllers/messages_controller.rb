class MessagesController < ApplicationController
  def create
    if Room.find(create_params['room_id'])
      message = Message.new(create_params)
      if message.save
        render json: {message: message}, status: 201
      else
        render_error_from_details(message.errors.details, 422)
      end
    else
      render_error('not_found', 404)
    end
  end

  def index
    if Room.find(index_params[:room_id])
      sort = define_sort(index_params[:sort])
      room_messages = Message.paginated_and_reversed(index_params[:room_id], nil, nil, sort)
      pagination_meta = pagination_meta
      render json: {messages: room_messages, links: pagination_meta}, status: 200
    else
      render_error('not_found', 404)
    end
  end

  private

  def create_params
    params.permit(:text, :author, :room_id)
  end

  def index_params
    params.permit(:room_id, :sort)
  end

  def define_sort(sort_param)
    order = sort_param[0] == '-' ? ' ASC' : ' DESC'
    sort_param[0] = '' if sort_param[0] == '-'
    sort_param + order
  end

  def pagination_meta
    if !index_params[:page] || index_params[:page] == 1
      { next: "page=2" }
    else
      { prev: "page=#{index_params[:page] - 1}"}
      { next: "page=#{index_params[:page] + 1}" }


    end
  end
end
