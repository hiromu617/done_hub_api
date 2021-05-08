class User < ApplicationRecord
  validates :name, presence: true
  validates :uid, presence: true, uniqueness: true
  validates_uniqueness_of :uid
  has_many :done_posts, dependent: :destroy
  has_many :replys, dependent: :destroy

  has_many :active_relationships, class_name:  "Relationship",
  foreign_key: "follower_id",
  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
  foreign_key: "followed_id",
  dependent:   :destroy
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_many :likes, dependent: :destroy
  acts_as_taggable_on :hubs
  
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  has_many :blocks, class_name:  "Block", foreign_key: "block_id", dependent:   :destroy
  has_many :block_users, through: :blocks, source: :blocked

  def feed
    following_ids = "SELECT followed_id FROM relationships
    WHERE follower_id = :user_id"
    DonePost.where("user_id IN (#{following_ids})
    OR user_id = :user_id", user_id: id)
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end
  
  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

  # ユーザーをブロックする
  def block(other_user)
    block_users << other_user
  end
  
  # ユーザーをブロック解除する
  def unblock(other_user)
    blocks.find_by(blocked_id: other_user.id).destroy
  end

  # 現在のユーザーがブロックしてたらtrueを返す
  def block?(other_user)
    block_users.include?(other_user)
  end
end
