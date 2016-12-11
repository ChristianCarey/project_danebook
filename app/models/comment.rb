class Comment < ApplicationRecord
  include Likable
  
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true

  default_scope { order(created_at: :desc) }
end
