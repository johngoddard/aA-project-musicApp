class User < ActiveRecord::Base
  validates :email, :session_token, :password_digest, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length:{minimum: 6, allow_nil: true}

  after_initialize :ensure_session_token
  after_initialize :ensure_not_activated
  after_initialize :ensure_activation_token

  attr_reader :password

  def self.find_by_credentials(email, password)
    prospect = User.find_by(email: email)
    return nil unless prospect
    prospect.is_password?(password) ? prospect : nil
  end

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.activate_user(user)
    user.activated = true
    user.save!
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

  def activated?
    self.activated
  end

  private

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def ensure_not_activated
    self.activated = false if self.activated != true
  end

  def ensure_activation_token
    self.activation_token = User.generate_session_token if self.activation_token == ""
  end
end
