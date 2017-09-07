require_relative 'journey'
require_relative 'station'
require_relative 'journey_log'

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
    @journey_log = Journey_log.new
  end

  def top_up(num)
    raise "Over limit £#{@limit}" if over_limit?(num)
    @balance += num
  end

  def over_limit?(num)
    @balance + num >= @limit
  end

  def touch_in(entry_station = Station.new(station, zone))
    raise 'Insufficient funds' if broke?
    @balance -= in_journey? ? @penalty : @minimum
    @entry_station = entry_station
    @journey.start_journey(@entry_station)
  end

  def touch_out(exit_station = Station.new(station, zone))
    balance = @balance
    @journey.end_journey(exit_station)
    @exit_station = exit_station
    @journey_log.log(@journey.current_journey)
    @balance -= in_journey? ? calculate_fare : @penalty
    @journey_fare = (balance - @balance)
    @journey.get_fare(@journey_fare)
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    !!@journey.entry_station
  end

  def broke?
    @balance <= @minimum
  end

  attr_reader :journey_log

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
