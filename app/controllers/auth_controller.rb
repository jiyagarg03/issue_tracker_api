class AuthController < ApplicationController
  SECRET_KEY = Rails.application.secret_key_base

  def signup
    user = User.new(user_params)

    if user.save
      token = encode_token({ user_id: user.id })
      render json: { token: token }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token }
    else
      render json: { error: "Invalid credentials" }, status: :unauthorized
    end
  end

  private

  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def user_params
    params.permit(:email, :password)
  end
end

