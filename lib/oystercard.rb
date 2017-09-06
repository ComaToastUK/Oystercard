require 'station'
require 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :history

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 7
  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @in_use = false
    @minimum = DEFAULT_MINIMUM
    @in_journey = false
    @journey = Journey.new
    @penalty = PENALTY_FARE
  end

  def top_up(num)
    raise "Over limit £#{@limit}" if over_limit?(num)
    @balance += num
  end

  def over_limit?(num)
    @balance + num >= @limit
  end

  def touch_in(entry_station)
    raise 'Insufficient funds' if broke?
    self.in_journey? ? @balance -= @penalty : @balance -= @minimum
    @entry_station = entry_station
    @journey.start_journey(@entry_station)
    @in_journey = true
  end

  def touch_out(exit_station)
    self.in_journey? ? @balance -= @minimum : @balance -= @penalty
    @entry_station = nil
    @journey.end_journey(exit_station)
    @in_journey = false
  end

  def in_journey?
    @in_journey == true
  end

  def broke?
    @balance <= @minimum
  end

  private

  def deduct(num)
    @balance -= num
  end
end
