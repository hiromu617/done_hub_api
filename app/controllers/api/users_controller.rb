class Api::UsersController < ApplicationController
  # protect_from_forgery
  
  def index
    @users = User.all
    render json: @users
  end

  def show
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    render json: @user
  end

  def create
    @user = User.find_or_initialize_by(user_params)
    # binding.pry
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    # binding.pry
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :uid)
  end

end
