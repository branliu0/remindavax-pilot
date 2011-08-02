class ActiveRecord::Base
  def self.creation_stats_by_week(phc_id)
    self.select("COUNT(1) as count, YEARWEEK(created_at, 1) as yrwk, YEAR(created_at) as year, WEEK(created_at, 1) as week")
      .where("phc_id = ?", phc_id)
      .group("yrwk")
      .order("yrwk DESC")
      # .map(&:attributes)
      # Seems better style to leave the control up to the caller
  end
end
