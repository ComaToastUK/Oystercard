class Oystercard

  attr_reader :balance
  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  def initialize(limit = DEFAULT_LIMIT)
    @balance = 0
    @limit = limit
    @in_use = false
    @minimum = DEFAULT_MINIMUM
  end

  def top_up(num)
    fail "Over limit £#{@limit}" if over_limit?(num)
    @balance += num
  end

  def over_limit?(num)
    @balance + num >= @limit
  end

  def touch_in
    fail 'Insufficient funds' if broke?
    @in_use = true
  end

  def touch_out
    @in_use = false
    deduct(@minimum)
  end

  def in_journey?
    @in_use
  end

  def broke?
    @balance <= @minimum
  end

  private
  
  def deduct(num)
    @balance -= num
  end
end
