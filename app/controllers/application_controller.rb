class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  private
  def authenticate
    redirect_to login_path if not logged_in?
  end
end
