class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :uid, :profile, :hub_list, :expo_push_token,:college,:faculty,:department

  has_many :done_posts
  # has_many :rerationships
  has_many :replys
  # has_many :notifications
  has_many :likes
end
