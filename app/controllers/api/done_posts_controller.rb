class Api::DonePostsController < ApplicationController
  # protect_from_forgery
  def index
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    @donePost = DonePost.where(user_id: @user.id).order(created_at: "DESC").page(params[:page]).per(5)
    render json: @donePost
  end
  
  def create
    # binding.pry
    @donePost = DonePost.new(
      title: done_post_params[:title],
      comment: done_post_params[:comment])

    @user = User.find_by(uid: done_post_params[:uid])

    @donePost.user_id = @user.id

    if @donePost.save
      render json: @donePost
    else
      render json: @donePost.errors, status: :unprocessable_entity
    end
  end

  def done_post_params
    params.require(:done_post).permit(:title, :uid, :comment)
  end

end
