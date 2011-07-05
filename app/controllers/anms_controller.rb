class AnmsController < ApplicationController
  before_filter :authorize, :only => [:show, :edit, :update, :destroy]

  def index
    @anms = current_user.phc.anms
  end

  def show
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
  end

  def update
    if @anm.update_attributes(params[:anm])
      flash[:success] = "Updated ANM!"
      redirect_to anms_path
    else
      render :edit
    end
  end

  def destroy
    @anm.destroy if @anm
    flash[:success] = "Successfully deleted #{@anm.name}"
    redirect_to anms_path
  end

  private
    def authorize
      @anm = Anm.find_by_id(params[:id])
      unless @anm && @anm.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this ANM"
        redirect_to anms_path
      end
    end
end
