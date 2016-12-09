class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i

  validates :password, length: { minimum: 6 },
                       presence: true,
                       allow_nil: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: VALID_EMAIL_REGEX },
                    presence: true

  before_create :generate_token
  before_save   :downcase_email
  after_create  :generate_profile

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_one  :profile, dependent: :destroy, inverse_of: :user
  has_many :likings, dependent: :destroy
  has_many :liked, through: :likings, source: :likable
  
  accepts_nested_attributes_for :profile

  has_secure_password

  def like(likable)
    liking = Liking.new(likable_id: likable.id, user_id: id, likable_type: likable.class.to_s)
    liking.save
  end

  def likes?(likable)
    likings.include?(likable)
  end

  def timeline
    posts.order(created_at: :desc)
  end

  def name
    "#{first_name} #{last_name}"
  end

  def generate_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: self.auth_token)
  end

  def regenerate_token
    self.auth_token = nil
    generate_token
    save!
  end

  def downcase_email
    self.email = email.downcase
  end

  def generate_profile
    self.profile = Profile.create
  end
end
