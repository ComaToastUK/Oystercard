require_relative 'journey_log'

class Journey

  attr_reader :current_journey, :journey_history

  def initialize
    @current_journey = { entry_station: 'Didn\'t touch in', exit_station: 'Didn\'t touch out', fare: nil }
  end

  def start_journey(entry_station)
    @current_journey[:entry_station] = entry_station
  end

  def end_journey(exit_station)
    @current_journey[:exit_station] = exit_station
    @journey_history = @current_journey.dup
  end

  def get_fare(fare)
    @current_journey[:fare] = fare
    @journey_history[:fare] = fare
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

  def reset_journey
    @current_journey[:entry_station] = 'Didn\'t touch in'
    @current_journey[:exit_station] = 'Didn\'t touch out'
    @current_journey[:fare] = nil
  end

  def journey_complete
    puts "Journey between #{@current_journey[:entry_station]} & #{@current_journey[:exit_station]} is complete. You have been charged £#{@current_journey[:fare]}"
  end

end
