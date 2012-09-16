class AppointmentsController < ApplicationController
  before_filter :authorize, :only => :destroy

  def create
    @patient = Patient.find(params[:id])
    @appointment = @patient.appointments.build(params[:appointment])
    if @appointment.save
      flash[:success] = 'Successfully added an appointment!'
      redirect_to @patient
    else
      flash[:error] = @appointment.errors.to_a
      redirect_to @patient
    end
  end

  def batch_update_dates
    @appointments = Appointment.find(params[:ids])
    @appointments.zip(params[:dates]).each do |appt_date|
      appt_date[0].update_attributes(:date => appt_date[1])
    end
    flash[:success] = "Successfully saved changes!" # TODO: Add errors?
    render :nothing => true # Client-side JS refreshes
  end

  def destroy
    @appt.destroy if @appt
    flash[:success] = "Successfully deleted appointment"
    redirect_to @appt.patient
  end

  private
    def authorize
      @appt = Appointment.find_by_id(params[:id])
      unless @appt && @appt.patient.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this appoinment"
        if @appt
          redirect_to @appt.patient
        else
          redirect_to patients_path
        end
      end
    end
end
