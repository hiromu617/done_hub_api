class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :uid

  has_many :done_posts
end
