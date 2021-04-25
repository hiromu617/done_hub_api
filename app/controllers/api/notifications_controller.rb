class Api::NotificationsController < ApplicationController
  def index
      # binding.pry
      @currentUser = User.find_by(uid: params[:uid])
      @notifications = @currentUser.passive_notifications
    #@notificationの中でまだ確認していない(indexに一度も遷移していない)通知のみ
      # @notifications.where(checked: false).each do |notification|
      #     notification.update_attributes(checked: true)
      # end
      render json: @notifications
  end
end
