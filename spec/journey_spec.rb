require './lib/journey'

describe Journey do
  describe "initialize" do
    it "checks journey was created" do
      journey = Journey.new
      expect(journey).to be_an_instance_of(Journey)
    end
  end
    describe "fare" do
    it "minimum fare is charged" do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.touch_in("kings cross")
      oystercard.touch_out("angel")
      expect(oystercard.journey.fare).to eq Journey::MINIMUM_FARE
    end
end
  describe "fare" do
    it "penalty fare is charged" do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.touch_in("kings cross")
      expect(oystercard.journey.fare).to eq Journey::PENALTY_FARE
    end
end
describe "fare" do
    it "penalty fare is charged" do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.touch_in(nil)
      oystercard.touch_out("kings cross")
      expect(oystercard.journey.fare).to eq Journey::PENALTY_FARE
    end
end
describe "finish" do
  it "checks journey is complete" do
      oystercard = Oystercard.new
      oystercard.top_up(10)
      oystercard.touch_in("kings cross")
      oystercard.touch_out("angel")
      expect(oystercard.journey.finish).to eq true
  end
end
end