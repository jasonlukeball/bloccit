class User < ApplicationRecord

  has_many :posts, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favourites, dependent: :destroy

  before_create :generate_auth_token
  before_save :downcase_email
  before_save :capitalize_name
  before_save :define_role

  validates :name, length: {minimum: 1, maximum: 100}, presence: true

  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest # executes only if password_digest is nil

  validates :password, length: { minimum: 6 }, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 254 }

  has_secure_password

  enum role: [:member, :admin, :moderator]


  def downcase_email
    self.email = email.downcase if email.present?
  end


  def capitalize_name
    self.name = name.split.map { |name_part| name_part.capitalize }.join(' ') if name
  end


  def define_role
    self.role ||= :member
    # shorthand for self.role = :member if self.role.nil?
  end


  def favourite_for(post)
    self.favourites.where(post_id: post.id).first
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def generate_auth_token
    loop do
      self.auth_token = SecureRandom.base64(64)
      break unless User.find_by(auth_token: self.auth_token)
    end
  end


end
