class Activity < ApplicationRecord
  belongs_to :user
  belongs_to :trackable, polymorphic: true

  default_scope { order('created_at DESC') }

  def self.timeline
    includes(
      { 
        trackable: [
                      :likings,
                      :likers,
                      { comments: [
                          :likings,
                          {
                            author: :profile_photo
                          }
                        ]
                      },
                      { author: :profile_photo }
                    ] 
      }
    )
  end
end
