class DonePost < ApplicationRecord
  belongs_to :user
  attr_accessor :uid
end
