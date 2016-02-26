class AuthenticationToken
  attr_reader :user

  def initialize(user:)
    @user = user
  end

  def self.reset(user:)
    new(user: user).reset
  end

  def reset
    params = { authentication_token: generate_unique_token,
               authentication_token_expires_at: expires_at }

    user.update(params)
  end

  def generate_unique_token
    token = generate_token

    until unique?(token)
      token = generate_token
    end

    token
  end

  def expires_at
    token_duration.days.from_now
  end

  private

  def generate_token
    SecureRandom.hex(20).encode('UTF-8')
  end

  def unique?(token)
    !existing_tokens.include?(token)
  end

  def existing_tokens
    @existing_tokens ||= User.pluck(:authentication_token)
  end

  def token_duration
    ENV.fetch('TOKEN_DURATION_DAYS').to_i
  end
end
