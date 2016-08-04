class User < ActiveRecord::Base
  validates :email, :session_token, :password_digest, presence: true
  validates :password, length:{minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token

  attr_reader :password

  def self.find_by_credentials(username, password)
    prospect = User.find_by(username: username)
    return nil unless prospect
    prospect.is_password?(password) ? prospect : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def password=(pw)
    @password = pw
    self.password_digest = BCrypt.password.create(pw)
  end

  def is_password?(pw)
    BCrypt.password.new(self.password_digest).is_password?(pw)
  end


  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end
end
