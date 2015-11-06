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
end
