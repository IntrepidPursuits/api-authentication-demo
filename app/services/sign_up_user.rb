class SignUpUser
  attr_reader :user_attrs

  def initialize(user_attrs)
    @user_attrs ||= user_attrs
  end

  def self.perform(user_attrs)
    new(user_attrs).perform
  end

  def perform
    if email_and_password?
      sign_up_user
    end
  end

  private

  def email_and_password?
    email.present? && password.present?
  end

  def email
    user_attrs[:email]
  end

  def password
    user_attrs[:password]
  end

  def sign_up_user
    user.tap do |user|
      user.reset_token!
      user.save!
    end
  end

  def user
    @user ||= Monban.config.sign_up_service.new(user_attrs).perform
  end
end
