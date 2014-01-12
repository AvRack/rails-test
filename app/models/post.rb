class Post < ActiveRecord::Base
  attr_accessible :title, :content, :tag_list
  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
  validates :user_id, presence: true

  default_scope order: 'posts.created_at DESC'
end
