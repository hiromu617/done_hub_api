class Api::ReplysController < ApplicationController
  def create
    @reply = Reply.new(reply_params)

    @donePost = DonePost.find(reply_params[:done_post_id])

    @current_user = User.find(reply_params[:user_id])
    
    if(@current_user.id != @donePost.user_id)
      @current_user.active_notifications.create(
        done_post_id:  @donePost.id,
        visited_id: @donePost.user_id,
        action: "reply"
      )
    end

    @donePost.replys.each do |reply|
      if @current_user.id != reply.user_id
        @current_user.active_notifications.create(
          done_post_id:  @donePost.id,
          visited_id: reply.user_id,
          action: "reply"
        )
      end
    end
    
    if @reply.save
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
  end

  private
  
  def reply_params
    params.require(:reply).permit(:content, :user_id, :done_post_id)
  end
end
