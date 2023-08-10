class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]

  def edit
  end

  def show
    @user = User.find(params[:id])
    @user_prptotypes = @user.prototypes

    if user_signed_in?
      @name = current_user.name
      @prottypes = current_user.prototypes
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :encrypted_password, :profile, :occupation, :position)
  end
end
