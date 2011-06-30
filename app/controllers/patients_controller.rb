class PatientsController < ApplicationController

  def index
    @patients = current_user.phc.patients.paginate(:page => params[:page])
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
      flash[:success] = "Created a new registration!"
      redirect_to @patient
    else
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update_attributes(params[:patient])
      flash[:success] = 'Updated registration!'
      redirect_to @patient
    else
      render :edit
    end
  end

  def destroy
    @patient = Patient.find_by_id(params[:id])
    @patient.destroy if @patient
    flash[:success] = "Successfully deleted registration"
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

  def autocomplete
    @patients = Patient.search(current_user.phc, params[:term]).map(&:name)
    respond_to do |format|
      format.json { render :json => @patients }
    end
  end

  def today
    @appts_today = current_user.phc.find_appointments_by_date(:date => Date.today)
    @overdue_appts = current_user.phc.find_appointments_by_date(:before => 2.days.ago)
  end

  def prepare_reminders
    get_reminders
  end

  def send_reminders
    appts = Appointment.find(params[:appointments])
    appts.each do |a|
      send_reminder(a) if a.patient.receiving_texts? && ( ! a.patient.subcenter.control?)
    end
    flash[:success] = "Successfully sent #{appts.length} reminders!"
    redirect_to patients_path
  end

  private
  def get_reminders
    @advance_reminders = current_user.phc.find_appointments_by_date(:date => 2.weeks.from_now.to_date) +
      current_user.phc.find_appointments_by_date(:date => 3.days.from_now.to_date)
    @reminders = current_user.phc.find_appointments_by_date(:date => 1.day.from_now.to_date)
    @alerts = current_user.phc.find_appointments_by_date(:before => 2.days.ago.to_date)
  end
end
