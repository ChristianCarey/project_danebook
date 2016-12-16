require 'active_support/concern'

module Trackable
  extend ActiveSupport::Concern

  included do 
    has_many :activities, as: :trackable, dependent: :destroy
    after_create :create_activity
  end

  def create_activity
    # TODO this depends on trackable having an author
    activities.create! trackable: self, user: author
  end
end
