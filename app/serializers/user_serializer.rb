class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :uid, :profile

  has_many :done_posts
end
