class Api::UsersController < ApplicationController
  # protect_from_forgery
  
  def index
    @users = User.all
    render json: @users
  end

  def show
    @currentUser = User.find_by(uid: params[:currentUserUid])
    @user = User.find_by(uid: params[:uid])
    render json:  {user: @user, following: @user.following, follower: @user.followers, isFollowed: @currentUser.following?(@user) }
  end

  def following
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    render json: {following: @user.following, follower: @user.followers }
  end

  def create
      # binding.pry
    @user = User.find_by(uid: user_params[:uid])
    if @user
      render json: @user
    else
      @user = User.create(user_params)
      # binding.pry
      if @user.save
        render json: @user
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
    
  end

  def update
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    if !@user 
      return 
    end
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :uid, :profile)
  end

end
