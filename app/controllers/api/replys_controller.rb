class Api::ReplysController < ApplicationController
  def create
    @reply = Reply.new(reply_params)

    if @reply.save
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  private
  
  def reply_params
    params.require(:reply).permit(:content, :user_id, :done_post_id)
  end
end
