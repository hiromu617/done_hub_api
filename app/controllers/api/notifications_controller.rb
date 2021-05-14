class Api::NotificationsController < ApplicationController
  def index
      # binding.pry
      @currentUser = User.find_by(uid: params[:uid])
      @notifications = @currentUser.passive_notifications.page(params[:page]).per(10)
      render json: @notifications, include: ['visiter', 'done_post' ,'done_post.user','done_post.replys','done_post.likes','done_post.replys.user','done_post.likes.user']

      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
      end
  end

  def update
    @notification = Notification.find(params[:id])
    @notification.update_attributes(checked: true)

    # @currentUser = User.find_by(id: @notification.visited_id)
    # render json: @currentUser.passive_notifications.where(checked: false).count
  end

  def count
    @currentUser = User.find_by(uid: params[:uid])
    render json: @currentUser.passive_notifications.where(checked: false).count
  end
end
