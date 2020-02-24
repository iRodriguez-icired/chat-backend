class ApplicationController < ActionController::API
  def render_error(error_message, status)
    render json: {errors: {'text': [{error: error_message}]}}, status: status
  end

  def render_error_from_details(error_details, status)
    render json: {errors: error_details}, status: status
  end
end
