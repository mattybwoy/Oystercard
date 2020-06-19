class Journey
attr_accessor :entry_station, :exit_station, :adventure
MINIMUM_FARE = 1
PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @adventure = false
  end

  def fare 
    finish ? MINIMUM_FARE : PENALTY_FARE
  end

   def complete?
     @adventure
  end

  def finish
    @adventure = true
    @entry_station != nil && @exit_station != nil
  end
end