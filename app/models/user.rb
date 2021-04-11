class User < ApplicationRecord
  mount_uploader :avatar, AvatarUploader
  has_many :done_posts
end
