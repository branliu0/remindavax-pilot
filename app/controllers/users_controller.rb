class UsersController < ApplicationController
  before_filter :admin_authenticate

  def new
    @user = User.new
    @phcs = Phc.all
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Successfully created a new user!"
      redirect_to '/'
    else
      @phcs = Phc.all
      render :new
    end
  end

end
