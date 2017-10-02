class SkipioController < ApplicationController

  def index
    skipio_params = {token: ENV['SKIPIO_API_TOKEN']}
    @skipio_user_info = FaradayConnect.new(ENV['SKIPIO_API_URL'], '/api/v2/users/me', skipio_params).send_get_request.data

    @skipio_contacts = FaradayConnect.new(ENV['SKIPIO_API_URL'], '/api/v2/contacts', skipio_params).send_get_request.data
  end

  def message
    @contact = params[:contact]
  end

  def send_message
    params.permit(:message_text, :contact_id)
    post_message_body = {
      "recipients": [
        "contact-#{params[:contact_id]}"
      ], 
      "message": {
        "body": params[:message_text]
      }
    }
    @send_message = FaradayConnect.new(ENV['SKIPIO_API_URL'], "/api/v2/messages?token=#{ENV['SKIPIO_API_TOKEN']}", post_message_body).send_post_request

    if @send_message == 201
      flash[:notice] = "Your message was successfully sent."
      redirect_to root_path
    else
      flash[:notice] = "There seems to be an error, we are unable to process your request at this time."
      redirect_to message_path 
    end

  end

end 