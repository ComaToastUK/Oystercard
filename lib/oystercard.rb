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
    @minimum = DEFAULT_MINIMUM
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
    @balance -= in_journey? ? @penalty : @minimum
    @entry_station = entry_station
    @journey.start_journey(@entry_station)
  end

  def touch_out(exit_station)
    balance = @balance
    @journey.end_journey(exit_station)
    @balance -= in_journey? ? calculate_fare : @penalty
    @journey_fare = (balance - @balance)
    @journey.journey_fare(@journey_fare)
    @entry_station = nil
  end

  def in_journey?
    !!@journey.entry_station
  end

  def broke?
    @balance <= @minimum
  end

  def journey_log
    @journey_log = Journey_log.new
    @journey_log.print_log
  end

  private

  def deduct(num)
    @balance -= num
  end

  def calculate_fare
    entry_station = @journey.entry_station
    exit_station = @journey.exit_station
    (exit_station[:zone] - entry_station[:zone]).abs + 1
  end
end
