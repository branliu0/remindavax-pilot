class TbPatientsController < ApplicationController
  before_filter :authorize, :only => [:show, :edit, :update, :destroy, :check_in]

  def index
    @tb_patients = current_user.phc.tb_patients.order("name ASC").paginate(:page => params[:page])
  end

  def show
    #@visit = @tb_patient.latest_visit
    @ongoing_treatments = @tb_patient.ongoing_treatments
    @previous_treatments = @tb_patient.previous_treatments
    @future_treatments = @tb_patient.future_treatments
    @treatment = Treatment.new
  end

  def new
    @tb_patient = TbPatient.new
  end

  def create
    @phc = current_user.phc
    @tb_patient = @phc.tb_patients.build(params[:tb_patient])
    if @tb_patient.save
      flash[:success] = "Created a new registration!"
      redirect_to @tb_patient
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tb_patient.update_attributes(params[:tb_patient])
      flash[:success] = 'Updated registration!'
      redirect_to @tb_patient
    else
      render :edit
    end
  end

  def destroy
    @tb_patient.destroy if @tb_patient
    flash[:success] = "Successfully deleted registration"
    flash[:success] += " #{@tb_patient.name}" if @tb_patient
    redirect_to tb_patients_path
  end

  def search
    if params[:q] # A query was actually entered
        @tb_patients = TbPatient.search(current_user.phc, params[:q]).order("name ASC").paginate(:page => params[:page])
        if @tb_patients.any?
          render :index
        else
          @tb_patient = TbPatient.new(:name => params[:q])
          render :new
        end
    else # Just rerender the search page if nothing was entered
      render :search
    end
  end

=begin
  def check_in
    if not @patient.checked_in?
      @patient.visits.create!(:date => Date.today, :description => params[:description])
    end
    respond_to do |format|
      format.html { redirect_to @patient }
      format.js
    end
  end

=end
  def autocomplete
    @tb_patients = TbPatient.search(current_user.phc, params[:term]).order("name ASC").map(&:name)
    respond_to do |format|
      format.json { render :json => @tb_patients }
    end
  end
=begin

  def today
    # Yesterday and today
    @appts_today = current_user.phc
      .find_appointments_by_date(:after => 2.days.ago.to_date, :before => Date.tomorrow)
      .order("date ASC")
    # More than 2 days ago
    @overdue_appts = current_user.phc
      .find_appointments_by_date(:before => 1.day.ago.to_date)
      .order("date ASC")
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

=end
  private
    def authorize
      @tb_patient = TbPatient.find(params[:id])
      unless @tb_patient && @tb_patient.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this patient"
        redirect_to tb_patients_path
      end
    end
=begin

    def get_reminders
      # Remind delivery appointments 2 weeks in advance
      @advance_reminders = current_user.phc.find_appointments_by_date(:date => 2.weeks.from_now.to_date).order("date ASC").select do |appt|
        appt.appointment_type.appointment_type_id == 4
      end
      @advance_reminders += current_user.phc.find_appointments_by_date(:date => 3.days.from_now.to_date).order("date ASC")
      @reminders = current_user.phc.find_appointments_by_date(:date => 1.day.from_now.to_date).order("date ASC")
      @alerts = current_user.phc.find_appointments_by_date(:before => 2.days.ago.to_date).order("date ASC")
    end
=end
end
