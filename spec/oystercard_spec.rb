require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

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

  describe 'deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }
    it 'deducts the amount' do
    expect { subject.deduct 3 }.to change { subject.balance }.by -3
    end
  end

end
