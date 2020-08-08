class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def require_login
    redirect_to root_path
  end
end
