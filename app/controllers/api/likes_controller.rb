class Api::LikesController < ApplicationController
  def create
    Like.create(like_params)
  end

  def destroy
    @like = Like.find_by(done_post_id: params[:done_post_id], user_id: params[:user_id])
    @like.destroy
  end

  private

    def like_params
      params.require(:like).permit(:user_id, :done_post_id)
    end
end
