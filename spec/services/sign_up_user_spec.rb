require 'rails_helper'

describe SignUpUser do
  describe '.perform' do
    context 'with valid email and password' do
      it 'creates a new user' do
        expect {
          SignUpUser.perform(email_attributes)
        }.to change { User.count }.from(0).to(1)
      end

      it 'returns the user' do
        result = SignUpUser.perform(email_attributes)

        expect(result).to be_a User
      end
    end

    context 'with invalid parameters' do
      context 'such as a preexisting email' do
        it 'raises an error' do
          create(:user, email: email_attributes[:email])

          expect {
            SignUpUser.perform(email_attributes)
          }.to raise_error ActiveRecord::RecordInvalid
        end
      end
    end
  end

  def email_attributes
    { email: 'lucille2@suddenvalley.co', password: 'password' }
  end
end
