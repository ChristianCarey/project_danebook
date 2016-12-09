class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :likings, as: :likable, dependent: :destroy
  has_many   :likers, through: :likings, source: :user
end
