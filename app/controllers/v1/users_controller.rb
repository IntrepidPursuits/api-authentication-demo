class V1::UsersController < V1::ApplicationController
  def create
    user = SignUpUser.perform(user_params)

    if user.save
      render json: user, serializer: AuthenticationSerializer, root: :user
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
