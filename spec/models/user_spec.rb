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

  describe '.for_authentication' do
    it 'returns a User with that token' do
      user = create(:user)

      user_from_token = User.for_authentication(user.authentication_token)

      expect(user_from_token).to eq user
    end

    context 'with expired token' do
      it 'returns nil' do
        user = create(:user, authentication_token_expires_at: 1.day.ago)

        user_from_token = User.for_authentication(user.authentication_token)

        expect(user_from_token).to be_nil
      end
    end

    context 'with invalid token' do
      it 'returns nil' do
        user_from_token = User.for_authentication('invalid-token')

        expect(user_from_token).to be_nil
      end
    end
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
