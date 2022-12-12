class Post < ApplicationRecord
  has_many :comments

  validates :user_id, presence: true, numericality: true
  validates :content, presence: true ,length: { maximum: 512 }
end
