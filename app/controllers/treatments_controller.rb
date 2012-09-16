class TreatmentsController < ApplicationController
  before_filter :authorize, :only => :destroy

  def create
    # TODO: Give some sort of feedback when the save fails
    @tb_patient = TbPatient.find(params[:id])
    @treatment = @tb_patient.treatments.build(params[:treatment])
    if @treatment.save
      flash[:success] = 'Successfully added an treatment!'
    end
    redirect_to @tb_patient
  end

=begin
  def batch_update_dates
    @appointments = Treatment.find(params[:ids])
    @appointments.zip(params[:dates]).each do |appt_date|
      appt_date[0].update_attributes(:date => appt_date[1])
    end
    flash[:success] = "Successfully saved changes!" # TODO: Add errors?
    render :nothing => true # Client-side JS refreshes
  end
=end

  def destroy
    @treatment.destroy if @treatment
    flash[:success] = "Successfully deleted treatment"
    redirect_to @treatment.tb_patient
  end

  private
    def authorize
      @treatment = Treatment.find_by_id(params[:id])
      unless @treatment && @treatment.tb_patient.phc.id == current_user.phc.id
        flash[:error] = "You do not have access to this appoinment"
        if @treatment
          redirect_to @treatment.tb_patient
        else
          redirect_to tb_patients_path
        end
      end
    end
end
