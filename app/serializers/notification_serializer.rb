class NotificationSerializer < ActiveModel::Serializer
  attributes :action, :id, :created_at, :checked
  belongs_to :done_post
  belongs_to :visiter ,serializer: UserSerializer
end
