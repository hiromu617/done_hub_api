class Api::LikesController < ApplicationController
  def create
    Like.create(like_params)
    @donePost = DonePost.find(like_params[:done_post_id])

    @current_user = User.find(like_params[:user_id])
    
    if(@current_user.id != @donePost.user_id)
      @current_user.active_notifications.create(
        done_post_id:  @donePost.id,
        visited_id: @donePost.user_id,
        action: "like"
      )
    end
    

    render json: @donePost.likes
  end

  def destroy
    @like = Like.find_by(done_post_id: params[:done_post_id], user_id: params[:user_id])
    @like.destroy

    @donePost = DonePost.find(params[:done_post_id])
    render json: @donePost.likes
  end

  private

    def like_params
      params.require(:like).permit(:user_id, :done_post_id)
    end
end
