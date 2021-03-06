class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :authentication_token, presence: true, uniqueness: true
  validates :authentication_token_expires_at, presence: true

  def reset_token!
    AuthenticationToken.reset(user: self)
  end
end
