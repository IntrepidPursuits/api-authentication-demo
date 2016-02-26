require 'rails_helper'

describe AuthenticationToken do
  describe '.reset' do
    it "updates the user's authentication token and token expiry" do
      user = create(:user)
      old_token = user.authentication_token
      old_expiry = user.authentication_token_expires_at

      AuthenticationToken.reset(user: user)

      expect(user.authentication_token).to be
      expect(user.authentication_token).not_to eq old_token
      expect(user.authentication_token_expires_at).to be
      expect(user.authentication_token_expires_at).not_to eq old_expiry
    end
  end

  describe '#generate_unique_token' do
    it 'makes a token' do
      token = AuthenticationToken.new(user: create(:user))
      expect(token.generate_unique_token).to be_a String
    end
  end

  describe '#expires_at' do
    it 'sets an expiration timestamp' do
      token = AuthenticationToken.new(user: create(:user))
      expect(token.expires_at).to be_a Time
    end

    it 'expires at the correct time' do
      token = AuthenticationToken.new(user: create(:user))
      expect(token.expires_at).
        to be_within(1).of(token_expiration_date)
    end
  end

  def token_expiration_date
    ENV.fetch('TOKEN_DURATION_DAYS').to_i.days.from_now
  end
end
