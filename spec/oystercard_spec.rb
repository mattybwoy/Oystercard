require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  let(:station) {double :station}
  # describe 'initialize' do
  #   it 'checks not in journey upon creation' do
  #   expect(subject.in_journey?).to eq false
  # end
  #end
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

 #describe 'deduct' do
    #it { is_expected.to respond_to(:deduct).with(1).argument }
    #it 'deducts the amount' do
    #expect { subject.deduct 3 }.to change { subject.balance }.by -3
    #end
  #end 
  

  describe 'touch_in' do
    it { is_expected.to respond_to(:touch_in) }
    it 'allows you to touch in' do
      subject.top_up(1)
      #expect(subject.balance).to_not be_zero
      expect(subject.touch_in(station)). to eq station
     # expect(subject.in_journey?).to eq true
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
      #expect(subject.touch_in).to eq true
      #expect(subject.in_journey?).to eq true
      expect(subject.in_journey?).to eq station
    end
  end
  describe 'touch_out' do
    it { is_expected.to respond_to(:touch_out) }
    it 'allows you to touch out' do
      subject.touch_out
      expect(subject.in_journey?).to eq nil 
    end
    it "deducts the fare from balance" do 
      subject.top_up(1)
      subject.touch_in(station)
    expect { subject.touch_out }.to change { subject.balance }.by -(Oystercard::MINIMUM_FARE)
  end
end
end
