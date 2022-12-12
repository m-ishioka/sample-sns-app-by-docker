class Comment < ApplicationRecord
  belongs_to :post

  validates :user_id, presence: true, numericality: true
  validates :post_id, presence: true, numericality: true
  validates :content, presence: true ,length: { maximum: 512 }
end
