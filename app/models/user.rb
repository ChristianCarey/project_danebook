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
  after_create  :create_profile

  has_many    :posts, foreign_key: :author_id, dependent: :destroy
  has_many    :photos, foreign_key: :author_id, dependent: :destroy
  has_many    :comments, foreign_key: :author_id, dependent: :destroy
  has_one     :profile, dependent: :destroy, inverse_of: :user
  has_many    :likings, dependent: :destroy
  has_many    :liked_posts, through: :likings, source: :likable, source_type: 'Post'
  has_many    :liked_comments, through: :likings, source: :likable, source_type: 'Comment'
  has_many    :liked_comments, through: :likings, source: :likable, source_type: 'Photo'
  has_many    :friendships, dependent: :destroy
  has_many    :friends, through: :friendships
  has_many    :inverse_friendships, class_name: 'Friendship', dependent: :destroy
  has_many    :inverse_friends, through: :inverse_friendships, source: :user
  belongs_to  :profile_photo, class_name: 'Photo', optional: :true

  
  accepts_nested_attributes_for :profile

  has_secure_password

  def like(likable)
    likable_type = likable.class.to_s
    association  = "liked_#{likable_type.downcase.pluralize}"
    send(association) << likable
  end

  def likes?(likable)
    liked.include?(likable)
  end

  def liked
    liked_posts + liked_comments
  end

  def timeline
    photos.order(created_at: :desc).includes({ comments: :author }, :likers, :likings, :author) +
    posts.order(created_at: :desc).includes({ comments: :author }, :likers, :likings, :author)  
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

  def friend_of?(other_user)
    friends.include?(other_user)
  end

  def self.send_welcome_email(user_id)
    UserMailer.welcome(find(user_id)).deliver!
  end

  private

  def downcase_email
    self.email = email.downcase if self.email
  end

  def create_profile
    self.profile = Profile.create
  end
end
