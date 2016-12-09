class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
  has_many   :likings, as: :likable
  has_many   :likers, through: :likings, source: :user
end
