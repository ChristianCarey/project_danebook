class Profile < ApplicationRecord
  belongs_to :user, inverse_of: :profile

  validate :birthday_cannot_be_in_future

  def birthday_cannot_be_in_future
    if birthday.present? && birthday > Date.today
      errors.add(:birthday, "Are you really from the future?")
    end
  end
end
