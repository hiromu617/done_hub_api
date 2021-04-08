class DonePost < ApplicationRecord
  attr_accessor :uid
  belongs_to :user
end
