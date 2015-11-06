require 'rails_helper'

describe 'Users endpoints' do
  describe 'POST /users' do
    context 'with valid email and password' do
      it 'returns JSON for a user' do
        user = create(:user)

        user_attributes = {
          user: {
            email: user.email,
            password: user.password_digest
          }
        }.to_json

        post(users_url, user_attributes, accept_headers)

        user.reload

        expect(response).to have_http_status :ok
        expect_response_to_include_user_info
      end
    end
  end

  def expect_response_to_include_user_info
    expect(json_value_at_path('user/email')).to eq user.email
    expect(json_value_at_path('user/authentication_token')).to eq user.authentication_token
    expect(json_value_at_path('user/authentication_token_expires_at')).to be
  end
end
