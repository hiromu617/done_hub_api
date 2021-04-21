class Api::DonePostsController < ApplicationController
  # protect_from_forgery
  def index
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    @donePost = DonePost.where(user_id: @user.id).order(created_at: "DESC").page(params[:page]).per(5)
    render json: @donePost, include: ['user', 'likes' ,'replys.user']
  end

  def show
    @donePost = DonePost.find(params[:id])
    render json: @donePost, include: ['user', 'likes' ,'replys.user']
  end
  
  def create
    @donePost = DonePost.new(
      title: done_post_params[:title],
      comment: done_post_params[:comment],
      tasks: [done_post_params[:tasks]]
    )

    @user = User.find_by(uid: params[:uid])

    @donePost.user_id = @user.id

    if @donePost.save
      render json: @donePost
    else
      render json: @donePost.errors, status: :unprocessable_entity
    end
  end

  def createList
    @donePost = DonePost.new(
      comment: params[:comment],
      tasks: params[:tasks]
    )

    @user = User.find_by(uid: params[:uid])

    @donePost.user_id = @user.id

    if @donePost.save
      render json: @donePost
    else
      render json: @donePost.errors, status: :unprocessable_entity
    end
  end

  private
  
  def done_post_params
    params.require(:done_post).permit(:tasks, :title, :uid, :comment)
  end

end
