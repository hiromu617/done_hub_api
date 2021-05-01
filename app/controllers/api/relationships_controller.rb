class Api::RelationshipsController < ApplicationController

  def create
    # binding.pry
    @current_user = User.find_by(uid: params[:currentUserUid])
    @user = User.find(params[:id])
    if(@current_user.id != @user.id)
      @current_user.active_notifications.create(
        visited_id: @user.id,
        action: "follow"
      )
      @current_user.follow(@user)
    end
    
  end

  def destroy
    @current_user = User.find_by(uid: params[:currentUserUid])
    @user = User.find(params[:id])
    @current_user.unfollow(@user)
  end
end
