class Journey_log
  attr_reader :journey_log

  def initialize
    @journey_log = []
  end

  def log(current_journey)
    @journey_log << current_journey
  end

  def print_log
      @journey_log.each_with_index do |journey|
      puts journey
    end
  end

end
