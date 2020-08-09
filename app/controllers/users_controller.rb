class UsersController < ApplicationController
  before_action :set_user, except: %i[new create]
  skip_before_action :require_login, only: %i[new create show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    unless same_user?(@user)
      flash[:danger] = 'Wrong User!'
      redirect_to(root_path) and return
    end
    if @user.update(user_params)
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
    params.require(:user).permit(:name, :handle_name, :mail, :password, :password_confirmation)
  end
end
