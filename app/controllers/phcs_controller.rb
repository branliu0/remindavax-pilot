class PhcsController < ApplicationController
  before_filter :admin_authenticate

  def new
    @phc = Phc.new
  end

  def create
    @phc = Phc.new(params[:phc])
    if @phc.save
      flash[:success] = "Successfully created a new PHC!"
      redirect_to '/'
    else
      render :new
    end
  end
end
