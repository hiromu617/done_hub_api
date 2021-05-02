class Api::NotificationsController < ApplicationController
  def index
      # binding.pry
      @currentUser = User.find_by(uid: params[:uid])
      @notifications = @currentUser.passive_notifications.page(params[:page]).per(10)
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
      # @notifications.where(checked: false).each do |notification|
      #     notification.update_attributes(checked: true)
      # end
      render json: @notifications, include: ['visiter', 'done_post' ,'done_post.user','done_post.replys','done_post.likes','done_post.replys.user','done_post.likes.user']
  end
end
