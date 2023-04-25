class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      render json: UserSerializer.format_user(user), status: :ok
    else
      render json: {error: "Incorrect Login."}, status: 400
    end
  end
end