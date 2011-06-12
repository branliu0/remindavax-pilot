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
    @appointments = @patient.scheduled_appointments
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
      redirect_to '/'
    else
      render :new
    end
  end

  def search
    if params[:q]
      @patients = Patient.search(current_user.phc, params[:q]).paginate(:page => params[:page])
      render :index
    else
      render :search
    end
  end

  def check_in
    @patient = Patient.find(params[:id])
    @patient.visits.create!(:date => Date.today)
    respond_to do |format|
      format.js
    end
  end
end
