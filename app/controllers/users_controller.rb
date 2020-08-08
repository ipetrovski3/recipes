class UsersController < ApplicationController
  before_action :set_user, except: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new
    if @user.save(user_params)
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @user.save(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def delete
    user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :handle_name, :email, :password, :password_confirmation)
  end
end
