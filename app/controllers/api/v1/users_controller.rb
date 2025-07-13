class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  def user_params
    # Handle both nested and flat parameter formats
    if params[:user]
      # Handle nested parameters with camelCase conversion
      user_params = params.require(:user).permit(:first_name, :last_name, :email, :firstName, :lastName)
      user_params.transform_keys do |key|
        case key.to_s
        when 'firstName'
          'first_name'
        when 'lastName'
          'last_name'
        else
          key
        end
      end
    else
      # Handle flat parameters from frontend
      params.permit(:firstName, :lastName, :email).transform_keys do |key|
        case key.to_s
        when 'firstName'
          'first_name'
        when 'lastName'
          'last_name'
        else
          key
        end
      end
    end
  end
end
