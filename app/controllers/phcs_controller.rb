class PhcsController < ApplicationController
  before_filter :admin_authenticate

  def index
    @phcs = Phc.all
  end

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

  def show
    @phc = Phc.find(params[:id])
    @subcenter = Subcenter.new(:phc_id => @phc)
  end
end
