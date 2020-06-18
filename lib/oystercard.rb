#require_relative 'station'
require_relative 'journey'

class Oystercard
MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
  attr_reader :balance, :journey

  def initialize
    @balance = 0
    @history = []
    @journey = nil
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
    #@entry_station = station
    @journey = Journey.new(station)
  end

  def in_journey?
    !@journey.complete?
  end

  def touch_out(station)
    @history << {entry_station: @journey.entry_station, exit_station: station }
    @journey.exit_station = station
    deduct(@journey.fare)
  end
end

private

  def deduct(amount = @journey.fare)
    @balance -= amount
  end