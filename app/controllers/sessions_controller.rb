class SessionsController < ApplicationController
  def new
    logged_in?
  end

  def create
    user = User.find_by(mail: params[:session][:mail].downcase)

    if user&.authenticate(params[:session][:password])
      login(user)
      flash[:success] = "Welcome #{user.name} !!!"
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email or password'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_path
  end
end
