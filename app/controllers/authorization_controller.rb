class AuthorizationController < ApplicationController
  include Authenticable

  def check_authorization
    token = request.headers['Authorization']
    response = Authenticable.validate_token(token)
    render json: { success: response }, status: status(response)
  end

  def status(response)
    response ? 200 : 401
  end
end
