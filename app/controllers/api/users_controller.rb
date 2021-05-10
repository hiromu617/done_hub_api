class Api::UsersController < ApplicationController
  # protect_from_forgery
  def showFeed
    @user = User.find_by(uid: params[:uid])
    render json: @user.feed.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user', 'likes.user']
  end

  def showFeedByHub
    @user = User.find_by(uid: params[:uid])
    @ids = User.tagged_with(@user.hub_list, :any => true).ids
    @donePosts = DonePost.where(user_id: @ids)
    render json: @donePosts.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user', 'likes.user']
  end

  def showFeedBySelectedHub
    # binding.pry
    @ids = User.tagged_with(params[:hub_list], :any => true).ids
    @donePosts = DonePost.where(user_id: @ids)
    render json: @donePosts.order(created_at: "DESC").page(params[:page]).per(10), include: ['user', 'likes' ,'replys.user', 'likes.user']
  end

  def updateHub
    # binding.pry
    @users = User.where(uid: params[:uid])
    if @users.count > 1
      (@users.count - 1).times do
        @users[0].destroy        
      end
    end
    @user = User.find_by(uid: params[:uid])
    @user.hub_list = params[:hub_list]
    
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def latestUsers
    render json: User.last(3), include: []
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
    render json:  {user: @user, following: @user.following, follower: @user.followers, isFollowed: @currentUser.following?(@user), blockState: {block: @currentUser.block?(@user), blocked: @user.block?(@currentUser)}, done_counts:  @user.done_posts.where.not(title: nil).count}
  end

  def following
    # binding.pry
    @user = User.find_by(uid: params[:uid])
    render json: {following: @user.following, follower: @user.followers, done_counts:  @user.done_posts.where.not(title: nil).count, block_users: @user.block_users}
  end

  def showUser
    @user = User.find_by(uid: params[:uid])
    if @user

      if @user.expo_push_token == '' && params[:expo_push_token] != nil
        @user.expo_push_token = params[:expo_push_token]
        @user.save
      end

      render json: @user, include: []
    else
      render json: nil
    end
  end

  def create
      # binding.pry
    # @users = User.where(uid: user_params[:uid])
    # if !@users.nil?
    #   @users.each do |u|
    #     u.destroy        
    #   end
    # end

      @newUser = User.new(user_params)
      # binding.pry
      if @newUser.save
        render json: @newUser
      else
        render json: @userUser.errors, status: :unprocessable_entity
      end
    # end
    
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

  def showDoneLog
    @user = User.find_by(uid: params[:uid])
    start_date =Time.zone.now.beginning_of_month
    end_date =Time.zone.now
    render json: @user.done_posts.where(created_at: start_date..end_date).group('DATE(created_at)').count
  end

  private

  def user_params
    params.require(:user).permit(:name, :uid, :profile, :expo_push_token)
  end

end
