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
    @user ||= User.
              where(authentication_token: token).
              where('authentication_token_expires_at > ?', Time.current).
              first
  end
end
