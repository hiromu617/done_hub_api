class Block < ApplicationRecord
  belongs_to :block, class_name: "User"
  belongs_to :blocked, class_name: "User"
end
