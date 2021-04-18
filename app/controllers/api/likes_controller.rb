class Api::LikesController < ApplicationController
  def create
    Like.create(like_params)
    @donePost = DonePost.find(like_params[:done_post_id])
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
