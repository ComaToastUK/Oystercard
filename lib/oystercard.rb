class Oystercard
  attr_reader :balance, :entry_station, :history

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @in_use = false
    @minimum = DEFAULT_MINIMUM
    @history = []
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
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    @entry_station = nil
    deduct(@minimum)
    @history << current_journey
  end

  def in_journey?
    !!@entry_station
  end

  def broke?
    @balance <= @minimum
  end

  private

  def deduct(num)
    @balance -= num
  end
end
