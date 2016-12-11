class Liking < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true, counter_cache: true

  validates_uniqueness_of :user_id, :scope => :likable_id
end
