require './lib/oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }

  describe 'balance' do
    it 'returns 0 by default' do
      expect(subject.balance).to eq 0
    end
  end
end
