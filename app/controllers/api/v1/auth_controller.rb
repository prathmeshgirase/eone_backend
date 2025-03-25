class Api::V1::AuthController < ApplicationController
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      if user.approved?
        token = JsonWebToken.encode(user_id: user.id)
        render json: { user: user.api_response(token) }, status: :ok
      else
        render json: { error: 'User approval is still pending' }, status: :unauthorized
      end
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end
end
