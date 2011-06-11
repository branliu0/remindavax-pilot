class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :set_timezone
  before_filter :authenticate

  private
  def authenticate
    if not logged_in?
      flash[:error] = "Please log in to access the page"
      redirect_to login_path
    end
  end

  def admin_authenticate
    if not (logged_in? && current_user.admin)
      flash[:error] = "You must be an administrator to access this page"
      redirect_to '/'
    end
  end

  def set_timezone
    min = request.cookies["time_zone"].to_i
    Time.zone = ActiveSupport::TimeZone[-min.minutes]
  end
end
