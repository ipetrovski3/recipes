class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :require_login
  before_action :page_title

  private

  def page_title
    @page_title
  end

  def require_login
    unless logged_in?
      flash[:danger] = 'Please sign in to continue'
      redirect_to login_path
    end
  end
end
