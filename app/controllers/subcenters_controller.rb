class SubcentersController < ApplicationController
  def new
    @subcenter = Subcenter.new
  end

  def create
    @subcenter = Subcenter.new(params[:subcenter])
    if @subcenter.save
      flash[:success] = "Successfully created a new Subcenter!"
      redirect_to phc_path(params[:phc_id])
    else
      render :new
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
