class NotificationSerializer < ActiveModel::Serializer
  attributes :action
  belongs_to :done_post
  belongs_to :visited ,serializer: UserSerializer
end
