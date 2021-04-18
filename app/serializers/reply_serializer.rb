class ReplySerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :done_post_id, :created_at

  belongs_to :user
  belongs_to :done_post
end