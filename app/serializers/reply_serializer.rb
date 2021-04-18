class ReplySerializer < ActiveModel::Serializer
  attributes :id, :content, :user_id, :done_post_id

  belongs_to :user
  belongs_to :done_post
end