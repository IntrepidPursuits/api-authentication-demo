class V1::UsersController < ApplicationController
  def create
    user = SignUpUser.perform(user_params)
    render json: user, serializer: AuthenticationSerializer, root: :user
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
