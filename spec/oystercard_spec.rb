require './lib/oystercard'
#require './lib/station'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  let(:station) {double :station}
  
  describe 'initialize' do
    it 'checks journey history is empty' do
      expect(subject.history).to be_an_instance_of(Array)
    end
  end
  describe 'balance' do
    it 'returns 0 by default' do
      expect(subject.balance).to eq 0
    end
  end

  describe 'top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }
  end
  it "raises an error if balance exceeded" do
  maximum_balance = Oystercard::MAXIMUM_BALANCE
  subject.top_up(maximum_balance)
  expect{ subject.top_up 91 }.to raise_error "Balance exceeded"
  end

  describe 'touch_in' do
    it { is_expected.to respond_to(:touch_in) }
    it 'allows you to touch in' do
      subject.top_up(1)
      expect(subject.touch_in(station)).to eq station
    end
    it 'raises an error if balance less than £1' do
      expect { subject.touch_in(station) }.to raise_error "Insufficient credit"
  end
    it 'should take station double as an argument' do
      subject.top_up(1)
      expect(subject.touch_in(station)).to eq(station)
    end
end
  describe 'in-journey?' do
    it { is_expected.to respond_to(:in_journey?) }
    it 'checks whether you are in journey' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.in_journey?).to eq station
    end
  end
  describe 'touch_out' do
    it { is_expected.to respond_to(:touch_out).with(1).argument }
    it 'allows you to touch out' do
      subject.touch_out(station)
      expect(subject.in_journey?).to eq nil 
    end
    it "deducts the fare from balance" do 
      subject.top_up(1)
      subject.touch_in(station)
    expect { subject.touch_out(station) }.to change { subject.balance }.by -(Oystercard::MINIMUM_FARE)
  end
end
  describe 'history' do
    it "storing completed journeys" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.history.length).to eq 1
    end
    it "creates a card with empty journey history" do
      oystercard = Oystercard.new
      expect(subject.journey).to eq({})
    end
end
end
