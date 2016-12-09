class Post < ApplicationRecord
  include Likable
  
  belongs_to :author, class_name: 'User'
  has_many   :comments, as: :commentable, dependent: :destroy

  validates :content, presence: true

  def self.timeline
    all.order(created_at: :desc)
  end
end
