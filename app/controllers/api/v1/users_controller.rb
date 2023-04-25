class Api::V1::UsersController < ApplicationController
  def create
    if user_params[:password] != user_params[:password_confirmation]
      render json: { error: 'Password and password confirmation do not match' }, status: 400
    elsif User.find_by(email: user_params[:email])
      render json: { error: 'Email already exists' }, status: 400
    elsif user_params[:email].blank? || user_params[:password].blank? || user_params[:password_confirmation].blank?
      render json: { error: 'Email, password, and password confirmation are required fields' }, status: 400
    else
      user = User.create(user_params.merge(api_key: generate_api_key))
      render json: UserSerializer.format_user(user), status: :created
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def generate_api_key
    SecureRandom.base58(26)
  end
end