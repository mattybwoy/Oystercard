class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize
    @balance = 0
    @history = []
    @entry_station = nil
    @exit_station = nil
    @journey = {}
  end

  def top_up(amount)
    fail "Balance exceeded" if @balance + amount > MAXIMUM_BALANCE
    @balance += amount
  end

  def history
    @history
  end

  def touch_in(station)
    fail 'Insufficient credit' if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def in_journey?
    @entry_station
  end

  def touch_out(station)
    @exit_station = station
    deduct(MINIMUM_FARE)
    adventure = {@entry_station => @exit_station}
    @history << adventure
    #@history << @journey[@entry_station] = @exit_station
    #@entry_station = nil
    @exit_station
  end
end

private

  def deduct(amount)
    @balance -= amount
  end