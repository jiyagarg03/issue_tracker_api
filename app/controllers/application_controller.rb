class ApplicationController < ActionController::API
  SECRET_KEY = Rails.application.secret_key_base

  def authorize_request
    header = request.headers["Authorization"]
    token = header.split(" ").last if header

    begin
      decoded = JWT.decode(token, SECRET_KEY)[0]
      @current_user = User.find(decoded["user_id"])
    rescue
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end

  def admin_only
  render json: { error: "Forbidden" }, status: :forbidden unless @current_user.admin?
  end
end
