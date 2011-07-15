class PatientsController < ApplicationController
  before_filter :authorize, :only => [:show, :edit, :update, :destroy, :check_in]

  def index
    @patients = current_user.phc.patients.paginate(:page => params[:page])
  end

  def show
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
  end

  def update
    if @patient.update_attributes(params[:patient])
      flash[:success] = 'Updated registration!'
      redirect_to @patient
    else
      render :edit
    end
  end

  def destroy
    @patient.destroy if @patient
    flash[:success] = "Successfully deleted registration"
    flash[:success] += " #{@patient.name}" if @patient
    redirect_to patients_path
  end

  def search
    if params[:q] # A query was actually entered
      if /\A\d{7}\Z/ === params[:q] # Entered an Taayi Card Number (7 digits)
        @patient = Patient.find_by_taayi_card_number(params[:q])
        if @patient
          redirect_to @patient
        else
          @patient = Patient.new(:taayi_card_number => params[:q])
          render :new
        end
      else # Entered a name
        @patients = Patient.search(current_user.phc, params[:q]).paginate(:page => params[:page])
        if @patients.any?
          render :index
        else
          @patient = Patient.new(:name => params[:q])
          render :new
        end
      end
    else # Just rerender the search page if nothing was entered
      render :search
    end
  end

  def check_in
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
    # Yesterday and today
    @appts_today = current_user.phc.find_appointments_by_date(:after => 2.days.ago.to_date, :before => Date.tomorrow)
    # More than 2 days ago
    @overdue_appts = current_user.phc.find_appointments_by_date(:before => 1.day.ago.to_date)
  end

  def prepare_reminders
    get_reminders
  end

  def send_reminders
    appts = Appointment.find(params[:appointments])
    appts.each do |a|
      send_reminder(a) unless a.patient.subcenter.control?
    end
    flash[:success] = "Successfully sent #{appts.length} reminders!"
    redirect_to patients_path
  end

  private
    def authorize
      @patient = Patient.find(params[:id])
      unless @patient && @patient.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this patient"
        redirect_to patients_path
      end
    end

    def get_reminders
      # Remind delivery appointments 2 weeks in advance
      @advance_reminders = current_user.phc.find_appointments_by_date(:date => 2.weeks.from_now.to_date).select do |appt|
        appt.appointment_type.appointment_type_id == 4
      end
      @advance_reminders += current_user.phc.find_appointments_by_date(:date => 3.days.from_now.to_date)
      @reminders = current_user.phc.find_appointments_by_date(:date => 1.day.from_now.to_date)
      @alerts = current_user.phc.find_appointments_by_date(:before => 2.days.ago.to_date)
    end
end
