class User < ActiveRecord::Base
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length:{minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(email, password)
    prospect = User.find_by(email: email)
    return nil unless prospect
    prospect.is_password?(password) ? prospect : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end


  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
