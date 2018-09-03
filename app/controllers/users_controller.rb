class UsersController < ApplicationController
  before_action :clear_current_user, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if User.exists?(email: @user.email) || @user.save
      set_current_user(user: @user)
      redirect_to new_quiz_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :house_choice)
  end

  def clear_current_user
    session[:email] = nil
  end
end
