class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :uid, :profile, :hub_list

  has_many :done_posts
  # has_many :rerationships
  has_many :replys
end
