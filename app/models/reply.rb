class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :done_post
end
