class Comment < ApplicationRecord
  include Likable
  
  belongs_to :author, class_name: 'User'
  belongs_to :commentable, polymorphic: true
end
