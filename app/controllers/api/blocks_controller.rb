class Api::BlocksController < ApplicationController
    def create
      # binding.pry
      @current_user = User.find_by(uid: params[:currentUserUid])
      @user = User.find(params[:id])
      if(@current_user.id != @user.id)
        @current_user.block(@user)
      end

      if(@current_user.following?(@user))
        @current_user.unfollow(@user)
      end

      if(@user.following?(@current_user))
        @user.unfollow(@current_user)
      end
    end
  
    def destroy
      @current_user = User.find_by(uid: params[:currentUserUid])
      @user = User.find(params[:id])
      @current_user.unblock(@user)
    end
end
