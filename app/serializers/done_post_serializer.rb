class DonePostSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment

  belongs_to :user
end
