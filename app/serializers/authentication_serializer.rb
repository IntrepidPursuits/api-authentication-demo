class AuthenticationSerializer < BaseSerializer
  attributes :email, :authentication_token, :authentication_token_expires_at
end
