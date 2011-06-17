class PatientsController < ApplicationController

  def index
    @patients = current_user.phc.patients.paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js { render :json => @patients.map(&:name) }
    end
  end

  def show
    @patient = Patient.find(params[:id])
    @visit = @patient.latest_visit
    @appointments = @patient.scheduled_appointments.dup
    @appointment = @patient.appointments.build
  end

  def new
    @patient = Patient.new
  end

  def create
    @phc = current_user.phc
    @patient = @phc.patients.build(params[:patient])
    if @patient.save
      flash[:success] = "Created a new patient!"
      redirect_to @patient
    else
      render :new
    end
  end
  
  def destroy
    @patient = Patient.find_by_id(params[:id])
    @patient.destroy if @patient
    flash[:success] = "Successfully deleted patient"
    flash[:success] += " #{@patient.name}" if @patient
    redirect_to patients_path
  end

  def search
    if params[:q]
      @patients = Patient.search(current_user.phc, params[:q]).paginate(:page => params[:page])
      if @patients.any?
        render :index
      else
        @patient = Patient.new(:name => params[:q])
        render :new
      end
    else
      render :search
    end
  end

  def check_in
    @patient = Patient.find(params[:id])
    if not @patient.checked_in?
      @patient.visits.create!(:date => Date.today, :description => params[:description])
    end
    respond_to do |format|
      format.html { redirect_to @patient }
      format.js
    end
  end
end
