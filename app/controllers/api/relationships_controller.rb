class Api::RelationshipsController < ApplicationController

  def create
    @current_user = User.find_by(uid: params[:currentUserUid])
    @user = User.find(params[:id])
    @current_user.follow(@user)
  end

  def destroy
    @current_user = User.find_by(uid: params[:currentUserUid])
    @user = User.find(params[:id])
    @current_user.unfollow(@user)
  end
end
