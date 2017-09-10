require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

class Oystercard

  attr_reader :balance, :entry_station, :history, :journey_log

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY_FARE = 6

  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @minimum = DEFAULT_MINIMUM
    @journey = Journey.new
    @penalty = PENALTY_FARE
    @journey_log = Journey_log.new
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
    @balance -= in_journey? ? @penalty : @minimum
    @entry_station = entry_station
    @journey.start_journey(@entry_station)
  end

  def touch_out(exit_station)
    balance = @balance
    @journey.end_journey(exit_station)
    @exit_station = exit_station
    @journey_log.log(@journey.journey_history)
    @balance -= in_journey? ? calculate_fare : @penalty
    @journey_fare = (balance - @balance)
    @journey.get_fare(@journey_fare)
    @entry_station = nil
    @exit_station = nil
    @journey.journey_complete
    @journey.reset_journey
  end

  def in_journey?
    !!@journey.entry_station
  end

  def broke?
    @balance <= @minimum
  end

  private

  def deduct(num)
    @balance -= num
  end

  def calculate_fare
    entry_station = @entry_station.zone
    exit_station = @exit_station.zone
    (exit_station - entry_station).abs + 1
  end
end
