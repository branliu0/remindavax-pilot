class AppointmentsController < ApplicationController
  def create
    # TODO: Give some sort of feedback when the save fails
    @patient = Patient.find(params[:id])
    @appointment = @patient.appointments.build(params[:appointment])
    if @appointment.save
      flash[:success] = 'Successfully added an appointment!'
    end
    redirect_to @patient
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
    @appt = Appointment.find_by_id(params[:id])
    @appt.destroy if @appt
    flash[:success] = "Successfully deleted appointment"
    redirect_to @appt.patient
  end
end
