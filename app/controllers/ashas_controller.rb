class AshasController < ApplicationController
  before_filter :authorize, :only => [:show, :edit, :update, :destroy]

  def index
    @ashas = current_user.phc.ashas
  end

  def show
  end

  def new
    @asha = Asha.new
  end

  def create
    @asha = current_user.phc.ashas.build(params[:asha])
    if @asha.save
      flash[:success] = "Created a new ASHA!"
      redirect_to ashas_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @asha.update_attributes(params[:asha])
      flash[:success] = "Updated ASHA!"
      redirect_to ashas_path
    else
      render :edit
    end
  end

  def destroy
    @asha.destroy if @asha
    flash[:success] = "Successfully deleted #{@asha.name}"
    redirect_to ashas_path
  end

  private
    def authorize
      @asha = Asha.find_by_id(params[:id])
      unless @asha && @asha.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this ASHA"
        redirect_to ashas_path
      end
    end
end
