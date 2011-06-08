class PatientsController < ApplicationController
  def new
    @patient = Patient.new
  end

  def create
    # Convert yes/no to boolean
    cell = params[:patient][:cell_access]
    params[:patient][:cell_access] = (cell == "yes") ? true :
                                     (cell == "no" ) ? false : nil

    # @phc = current_user.phc
    @phc = Phc.find_by_name("testphc") # Remove
    @patient = @phc.patients.build(params[:patient])
    if @patient.save
      flash[:success] = "Created a new patient!"
      redirect_to '/'
    else
      render :new
    end
  end

  def search
  end
end
