class AppointmentsController < ApplicationController
  def create
    @patient = Patient.find(params[:id])
    @appointment = @patient.appointments.build(params[:appointment])
    @appointment.save

    respond_to do |format|
      format.html do
        @appointments = @patient.scheduled_appointments
        @visit = @patient.latest_visit
        @appointment = @patient.appointments.build if not @appointment.errors.any?
        render 'patients/show', :id => @patient
      end
      format.js
    end
  end

  def destroy
    @appt = Appointment.find_by_id(params[:id])
    @appt.destroy if @appt
    flash[:success] = "Successfully deleted appointment"
    redirect_to @appt.patient
  end
end
