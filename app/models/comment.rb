class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id, :user_id
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 200 }
end
