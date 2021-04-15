class DonePostSerializer < ActiveModel::Serializer
  attributes :id, :title, :comment, :created_at

  belongs_to :user
end