class Api::UsersController < ApplicationController
  # protect_from_forgery
  def showFeed
    @user = User.find_by(uid: params[:uid])
    render json: @user.feed.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user']
  end

  def showFeedByHub
    @user = User.find_by(uid: params[:uid])
    @ids = User.tagged_with(@user.hub_list, :any => true).ids
    @donePosts = DonePost.where(user_id: @ids)
    render json: @donePosts.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user']
  end

  def showFeedBySelectedHub
    binding.pry
    @ids = User.tagged_with(params[:hub_list], :any => true).ids
    @donePosts = DonePost.where(user_id: @ids)
    render json: @donePosts.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user']
  end

  def updateHub
    binding.pry
    @user = User.find_by(uid: params[:uid])
    @user.hub_list = params[:hub_list]
    
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def search
    @q = User.ransack(name_cont: params[:q])
    @users = @q.result(distinct: true)
    render json: @users , include: []
  end

  def index
    @users = User.all
    render json: @users , include: []
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
