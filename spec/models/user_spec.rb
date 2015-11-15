require 'rails_helper'

describe User do
  describe 'validations' do
    let!(:user) { create(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:authentication_token) }
    it { should validate_uniqueness_of(:authentication_token) }
    it { should validate_presence_of(:authentication_token_expires_at) }
  end

  describe '#reset_token!' do
    it 'creates a new unique token for that user' do
      user = create(:user)
      token = user.authentication_token

      user.reset_token!

      expect(user.authentication_token).not_to eq(token)
    end

    it "refreshes the token's expiration date" do
      user = create(:user, authentication_token_expires_at: Time.current)

      user.reset_token!

      expect(user.authentication_token_expires_at).to be_within(1).
                                                      of(30.days.from_now)
    end
  end
end
