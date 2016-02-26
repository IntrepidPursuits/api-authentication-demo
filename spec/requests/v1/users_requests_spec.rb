require 'rails_helper'

describe 'Users endpoints' do
  describe 'POST /users' do
    context 'with valid email and password' do
      it 'returns JSON for a user' do
        user_attributes = {
          user: {
            email: user.email,
            password: user.password_digest
          }
        }.to_json

        post(users_url, user_attributes, accept_headers)

        expect(response).to have_http_status :ok
        expect_response_to_include_user_info
      end
    end

    context 'with errors' do
      context 'such as a pre-existing email' do
        it 'returns a 422 response and JSON for errors' do
          existing_user = create(:user)

          user_attributes = {
            user: {
              email: existing_user.email,
              password: user.password_digest
            }
          }.to_json

          post(users_url, user_attributes, accept_headers)

          expect(response).to have_http_status :unprocessable_entity
          expect(json_value_at_path('errors')).to eq 'Validation failed: Email has already been taken'
        end
      end
    end
  end

  def user
    @user ||= build(:user)
  end

  def expect_response_to_include_user_info
    expect(json_value_at_path('user/email')).to eq user.email
    expect(json_value_at_path('user/authentication_token')).to be
    expect(json_value_at_path('user/authentication_token_expires_at')).to be
  end
end
