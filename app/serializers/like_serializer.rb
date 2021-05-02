class LikeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :done_post_id

  belongs_to :done_post
  belongs_to :user
end
