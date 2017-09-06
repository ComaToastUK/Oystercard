require 'oystercard'
require 'station'
require 'journey_log'

class Journey
  attr_reader :journey_history

  def initialize
    @current_journey = { entry_station: nil, exit_station: nil }
    @journey_log = Journey_log.new
  end

  def start_journey(entry_station)
    @current_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @current_journey[:exit_station] = exit_station
    @journey_log.log(@current_journey)
  end

  def entry_station
    @current_journey[:entry_station]
  end

  def exit_station
    @current_journey[:exit_station]
  end
end
