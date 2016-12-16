class Photo < ApplicationRecord
  include Likable
  include Commentable
  include Trackable

  belongs_to :author, class_name: 'User'
  has_one    :profiler, class_name: 'User'

  has_attached_file :image, styles: { large: "500x500", medium: "300x300", thumb: "100x100" }
  
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.timeline
    all.order(created_at: :desc).includes({ comments: :author }, :likers, :likings, :author)
  end
end
