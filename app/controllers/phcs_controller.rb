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

  CHART_URL = "https://chart.googleapis.com/chart?cht=lc&chs=800x200&chxt=y&chds=a&"
  def summary
    # Details on patients with mobile phones
    @num_patients = Patient.count
    @num_patients_with_mobile = Patient.all.count do |p|
      p.mobile.size > 0 && (p.anm.nil? || p.mobile != p.anm.mobile)
    end
    @percentage = 100*@num_patients_with_mobile/@num_patients

    phcs = current_user.admin? ? Phc.all : [ current_user.phc ]
    @creation_stats = []
    each_block = Proc.new do |hash, key, week|
      hash[week.yrwk] ||= {}
      hash[week.yrwk].merge!(key => week.count)
    end

    # Collect the stats
    phcs.each do |phc|
      stats = Hash.new
      Patient.creation_stats_by_week(phc).each { |week| each_block.call(stats, :patient_count, week) }
      Appointment.creation_stats_by_week(phc).each { |week| each_block.call(stats, :appointment_count, week) }
      Visit.creation_stats_by_week(phc).each { |week| each_block.call(stats, :visit_count, week) }
      Sms.creation_stats_by_week(phc).each { |week| each_block.call(stats, :sms_count, week) }
      stats.map do |yrwk, data|
        stats[yrwk][:week_start] = Date.commercial(yrwk / 100, yrwk % 100, 1)
        stats[yrwk][:week_end] = Date.commercial(yrwk / 100, yrwk % 100, 7)
      end

      # Add in the weeks with no data
      stats = stats.to_a.sort{ |a,b| a[0] <=> b[0] } # Sort by yrwk ASC
      if stats.any?
        day = stats[0][1][:week_start]
        logger.debug "#{day}"
        i = 0
        while day < Date.today
          if i < stats.length && day == stats[i][1][:week_start]
            i += 1
          else
            stats << [100 * day.cwyear + day.cweek, { week_start: day, week_end: day + 6.days }]
          end
          day += 7.days
        end
      end

      # Generate the chart URLs
      chart_url = ""
      stats = stats.sort{ |a,b| a[0] <=> b[0] } # by yrwk ASC
        .map{ |x| x[1] } # Just make it an array of hashes, discarding the yrwk key
      if stats.any?
        patient_data = stats.map{ |r| r[:patient_count] || 0 }
        patient_data.length.times do |i|
          if i == 0
            stats[i][:patient_partial_count] = patient_data[0]
          else
            stats[i][:patient_partial_count] = patient_data[i] + stats[i-1][:patient_partial_count]
          end
        end
        partial_sums = stats.map{ |r| r[:patient_partial_count] }
        chart_url = CHART_URL + "chxr=0,0,#{partial_sums[-1]*11/10}&chd=t:#{partial_sums.join(",")}"
      end

      @creation_stats << [phc.name, stats.reverse, chart_url]
    end
  end
end
