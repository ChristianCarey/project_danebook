require 'active_support/concern'

module Likable
  extend ActiveSupport::Concern

  included do 
    has_many   :likings, as: :likable, dependent: :destroy
    has_many   :likers, through: :likings, source: :user
  end
end