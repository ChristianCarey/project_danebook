class Comment < ApplicationRecord
  include Likable
  
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  validates :content, presence: true
  
  default_scope { order(created_at: :asc) }

  def self.send_commented_email(args = {})
    commenter = User.find(args.fetch(:commenter_id))
    commented = User.find(args.fetch(:commented_id))
    comment   = find(args.fetch(:comment_id))
    CommentMailer.new_comment(
      commenter: commenter,
      commented: commented,
      comment:   comment
      ).deliver!
  end
end
