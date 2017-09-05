require 'oystercard'
require 'station'

class Journey

  def initialize(entry_station)
    @current_journey = {entry_station: entry_station}
  end

  def entry_station
    @current_journey[:entry_station]
  end

  

end
