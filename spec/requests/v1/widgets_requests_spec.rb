require 'rails_helper'

describe 'WidgetsController endpoints' do
  describe 'GET /widgets' do
    context 'with authenticated user' do
      it 'returns a success response' do
        user = create(:user)

        get(widgets_url, {}, authorization_headers(user))

        expect(response).to have_http_status :ok
      end
    end

    context 'without authenticated user' do
      it 'returns a 401 - Unauthorized response' do
        get(widgets_url, {}, accept_headers)

        expect(response).to have_http_status :unauthorized
      end
    end
  end
end
