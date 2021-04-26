class NotificationSerializer < ActiveModel::Serializer
  attributes :action, :id
  belongs_to :done_post
  belongs_to :visiter ,serializer: UserSerializer
end
