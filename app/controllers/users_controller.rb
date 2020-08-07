class UsersController < ApplicationController
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

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.save(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def delete
    user = User.find(params[:id])
    user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :handle_name, :email, :password, :password_confirmation)
  end
end
