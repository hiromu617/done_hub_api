class Like < ApplicationRecord
  belongs_to :done_post
  belongs_to :user
  belongs_to :user
  belongs_to :done_post
  validates_uniqueness_of :done_post_id, scope: :user_id
end
