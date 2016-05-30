class AuthorizationController < ApplicationController
  include Authenticable

  def check_authorization
    token = request.headers['Authorization']
    response = Authenticable.validate_token(token)
    render json: { success: response }, status: status(response)
  end

  def create
    id = params[:id]
    record = AuthKey.find_or_create_by(id: id)
    record.token = AuthKey.generate_authentication_token
    record.token_created_at = Time.now
    if record.save
      render json: build_data_object(record), status: 201
    else
      render json: build_error_object(record), status: 422
    end
  end

  def destroy
    record = AuthKey.find_by(token: params[:id])
    if record.present?
      record.token = AuthKey.generate_authentication_token
      record.save
      render json: { success: true }, status: 200
    else
      render json: { success: false, errors: 'Could not find this user' }, status: 401
    end
  end

  def status(response)
    response ? 200 : 401
  end
end
