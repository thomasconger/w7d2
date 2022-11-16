# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :session_token, presence: true

  before_validation :ensure_session_token

  #SPIRE

  def self.find_by_credentials(username, password)
    user = User.find_by(user: username)
    if user & user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password(password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = generate_unique_session_token
    save!
    session_token
  end

  def generate_unique_session_token
    session_token = SecureRandom::urlsafe_base64
    while User.exists?(session_token: session_token)
      session_token = SecureRandom::urlsafe_base64
    end
    session_token
  end

  def ensure_session_token
    self.session_token ||= generate_unique_session_token
  end

end
