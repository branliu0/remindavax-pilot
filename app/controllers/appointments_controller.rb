class AppointmentsController < ApplicationController
  def create
    @patient = Patient.find(params[:id])
    @appointment = @patient.appointments.build(params[:appointment])
    @appointment.save

    respond_to do |format|
      format.html do
        flash[:success] = 'Successfully added an appointment!'
        redirect_to @patient
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
