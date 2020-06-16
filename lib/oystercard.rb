class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station)
    fail 'Insufficient credit' if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def in_journey?
    @entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end
end

private

  def deduct(amount)
    @balance -= amount
  end