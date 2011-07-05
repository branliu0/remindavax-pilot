class SubcentersController < ApplicationController
  before_filter :admin_authenticate

  def new
    @subcenter = Subcenter.new
  end

  def create
    @phc = Phc.find(params[:phc_id])
    @subcenter = @phc.subcenters.build(params[:subcenter])
    if @subcenter.save
      flash[:success] = "Successfully created a new Subcenter!"
      redirect_to phc_path(params[:phc_id])
    else
      render 'phcs/show', :id => @phc
    end
  end

  def show
    @subcenter = Subcenter.find(params[:id])
  end

  def destroy
    @subcenter = Subcenter.find(params[:id])
    @subcenter.destroy
    flash[:success] = "Successfully deleted the subcenter!"
  end
end
