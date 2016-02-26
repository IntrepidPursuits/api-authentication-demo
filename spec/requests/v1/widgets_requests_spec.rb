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
  end
end
