class PhcsController < ApplicationController
  before_filter :admin_authenticate, :except => :summary

  def index
    @phcs = Phc.all
  end

  def new
    @phc = Phc.new
  end

  def create
    @phc = Phc.new(params[:phc])
    if @phc.save
      flash[:success] = "Successfully created a new PHC!"
      redirect_to '/'
    else
      render :new
    end
  end

  def show
    @phc = Phc.find(params[:id])
    @subcenter = Subcenter.new(:phc_id => @phc)
  end

  def summary
    phcs = current_user.admin? ? Phc.all : [ current_user.phc ]
    @creation_stats = []
    each_block = Proc.new do |hash, key, week|
      hash[week.yrwk] ||= {}
      hash[week.yrwk].merge!(key => week.count)
    end

    phcs.each do |phc|
      stats = Hash.new
      Patient.creation_stats_by_week(current_user.phc).each { |week| each_block.call(:patient_count, week) }
      Appointment.creation_stats_by_week(current_user.phc).each { |week| each_block.call(:appointment_count, week) }
      Visit.creation_stats_by_week(current_user.phc).each { |week| each_block.call(:visit_count, week) }
      Sms.creation_stats_by_week(current_user.phc).each { |week| each_block.call(:sms_count, week) }
      stats.map do |yrwk, data|
        stats[yrwk][:week_start] = Date.commercial(yrwk / 100, yrwk % 100, 1)
        stats[yrwk][:week_end] = Date.commercial(yrwk / 100, yrwk % 100, 7)
      end
      stats = stats.to_a.sort{ |a,b| b[0] <=> a[0] } # by yrwk DESC
        .map{ |x| x[1] } # Just make it an array of hashes, discarding the yrwk key
      @creation_stats << stats
    end
  end
end
