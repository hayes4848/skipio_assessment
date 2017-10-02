class SkipioController < ApplicationController

  def index
    skipio_params = {token: ENV['SKIPIO_API_TOKEN']}
    @skipio_user_info = FaradayConnect.new(ENV['SKIPIO_API_URL'], '/api/v2/users/me', skipio_params).send_get_request.data

    @skipio_contacts = FaradayConnect.new(ENV['SKIPIO_API_URL'], '/api/v2/contacts', skipio_params).send_get_request.data
  end

end 