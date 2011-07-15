class SessionsController < ApplicationController
  before_filter :logged_in_authenticate, :except => [:new, :create]
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
end
