class TokenAuthenticationStrategy < Warden::Strategies::Base
  def valid?
    env['HTTP_AUTHORIZATION'].present?
  end

  def authenticate!
    if user
      success!(user)
    else
      fail!(I18n.t('warden.messages.failure'))
    end
  end

  def store?
    false
  end

  def token
    env['HTTP_AUTHORIZATION'].sub('Token token=', '')
  end

  def user
    @user ||= User.for_authentication(token)
  end
end
