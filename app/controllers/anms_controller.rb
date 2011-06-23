class AnmsController < ApplicationController
  def index
    @anms = current_user.phc.anms
  end

  def show
    @anm = Anm.find(params[:id])
  end

  def new
    @anm = Anm.new
  end

  def create
    @anm = current_user.phc.anms.build(params[:anm])
    if @anm.save
      flash[:success] = "Created a new ANM!"
      redirect_to anms_path
    else
      render :new
    end
  end

  def edit
    @anm = Anm.find(params[:id])
  end

  def update
    @anm = Anm.find(params[:id])
    if @anm.update_attributes(params[:anm])
      flash[:success] = "Updated ANM!"
      redirect_to anms_path
    else
      render :edit
    end
  end

  def destroy
    @anm = Anm.find_by_id(params[:id])
    @anm.destroy if @anm
    flash[:success] = "Successfully deleted #{@anm.name}"
    redirect_to anms_path
  end

end
