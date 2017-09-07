class Journey_log
  attr_reader :journey_log

  def initialize
    @journey_log = []
  end

  def log(current_journey)
    @journey_log << current_journey
  end

  def print_log
    p @journey_log.to_s
  end
end
