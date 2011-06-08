class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:session][:username], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination"
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
