class SessionsController < ApplicationController
  before_filter :logged_in_authenticate, :except => [:new, :create]
  before_filter :admin_authenticate, :become_user
  before_filter :become_user_authenticate, :become_user

  def new
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid username/password combination"
      render :new
    else
      login user
      redirect_to root_path
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

  # Used to become any user in the system for debugging purposes
  protected
    def become_user_authenticate
      authenticate_or_request_with_http_basic do |username, password|
        username == "remindavax" && password == "RemindaVax123"
      end
    end

  private
    def become_user
      if params[:username]
        user = User.find_by_username(params[:username])
        if user
          login user
          flash[:success] = "Successfully logged in as #{user.username}"
          redirect_to root_path
        else
          flash.now[:error] = "This user could not be found!"
        end
      end
    end
end
