class Post < ApplicationRecord
  include Likable
  include Commentable
  include Trackable
  
  belongs_to :author, class_name: 'User'
  validates :content, presence: true

  def self.timeline
    all.order(created_at: :desc).includes({ comments: :author }, :likers, :likings, :author)
  end
end
