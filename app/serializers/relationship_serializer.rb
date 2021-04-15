class RelationshipSerializer < ActiveModel::Serializer
  attributes  :follower_id, :followed_id,
end
