class DonePost < ApplicationRecord
  attr_accessor :uid
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :replys, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :notifications, dependent: :destroy
end
