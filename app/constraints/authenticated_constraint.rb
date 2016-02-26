class AuthenticatedConstraint
  def matches?(request)
    warden = request.env['warden']
    warden && warden.authenticate!(:token_authentication_strategy)
  end
end

Warden::Strategies.add(:token_authentication_strategy,
                       TokenAuthenticationStrategy)
