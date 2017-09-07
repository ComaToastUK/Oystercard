require_relative 'journey_log'

class Journey
  attr_reader :current_journey

  def initialize
    @current_journey = { :entry_station => nil, :exit_station => nil, :fare => nil }
  end

  def start_journey(entry_station)
    @current_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @current_journey[:exit_station] = exit_station
  end

  def entry_station
    @current_journey[:entry_station]
  end

  def exit_station
    @current_journey[:exit_station]
  end

  def fare
    @current_journey[:fare]
  end

end
