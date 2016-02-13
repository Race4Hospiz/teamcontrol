# == Schema Information
#
# Table name: races
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  duration       :integer
#  max_drive      :integer
#  max_turn       :integer
#  break_time     :integer
#  waiting_period :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  slug           :string(255)
#  state          :integer
#  mode           :integer
#  scheduled      :date
#  started_at     :datetime
#  finished_at    :datetime
#
# Indexes
#
#  index_races_on_mode  (mode)
#  index_races_on_slug  (slug)
#

module RacesHelper
  def current_race
    return Race.find session[:current_race] if session[:current_race]
    Race.current_race
  end

  def minutes_to_time(total_minutes)
    minutes = total_minutes % 60
    hours = total_minutes / 60

    if hours > 0
      return format('%02d Stunden %02d Minuten', hours, minutes)
    end
    format('%02d Minuten', minutes)
  end
end
