require 'oystercard'

RSpec.describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe '#initialize' do
    it 'has a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'increases the balance by 1' do
      expect { subject.top_up 1 }.to change { subject.balance }.by 1
    end
  end

  describe '#over_limit' do
    it 'raises an error if over limit' do
      message = "Over limit £#{Oystercard::DEFAULT_LIMIT}"
      expect { subject.top_up(Oystercard::DEFAULT_LIMIT) }.to raise_error message
    end
  end

  describe '#deduct' do
    it 'deducts money from balance' do
      subject.top_up(50)
      expect { subject.instance_eval { deduct(10) } }.to change { subject.balance }.by -10
    end
  end

  describe '#touch_in' do
    let(:entry_station) { double :entry_station }

    it 'changes the oystercard status of in_use to true' do
      subject.top_up(50)
      expect { subject.touch_in(entry_station) }.to change { subject.in_journey? }.to true
    end
    it 'raises_error if under £1' do
      message = 'Insufficient funds'
      expect { subject.touch_in(entry_station) }.to raise_error message
    end
    it 'remembers entry station' do
      subject.top_up(50)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
    it 'deducts a PENALTY_FARE if the user failed to touch out previously' do
      subject.top_up(50)
      subject.touch_in(entry_station)
      penalty = Oystercard::PENALTY_FARE
      expect { subject.touch_in(entry_station) }.to change { subject.balance }.by -penalty
    end
  end

  describe '#touch_out(exit_station)' do
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }

    # it 'changes the balance by minimum' do
    #   subject.top_up(50)
    #   subject.touch_in(entry_station)
    #   expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::DEFAULT_MINIMUM
    # end
    # ****************************************************************************************
    # it 'changes the value of entry_station to nil' do
    #   subject.top_up(50)
    #   # journey = double :journey
    #   # enter = { :name => "Old Street", :zone => 1}
    #   # leave = { :name => "Bounds Green", :zone => 4 }
    #   # allow(journey).to receive(:entry_station).and_return enter
    #   # allow(journey).to receive(:exit_station).and_return leave
    #   subject.touch_in(entry_station)
    #   expect { subject.touch_out(exit_station) }.to change { subject.entry_station }.to nil
    # end
    # ****************************************************************************************
    it 'deducts a PENALTY_FARE if the user failed to touch in previously' do
      subject.top_up(50)
      journey = double :journey
      enter = { name: nil, zone: nil }
      leave = { name: 'Bounds Green', zone: 4 }
      allow(journey).to receive(:entry_station).and_return enter
      allow(journey).to receive(:exit_station).and_return leave
      penalty = Oystercard::PENALTY_FARE
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -penalty
    end
  end
  # *****************************************************************************
  # it 'calculates a fare' do
  #   subject.top_up(50)
  #   journey = double :journey
  #   enter = { :name => "Old Street", :zone => 1}
  #   leave = { :name => "Bounds Green", :zone => 4 }
  #   allow(journey).to receive(:entry_station).and_return enter
  #   allow(journey).to receive(:exit_station).and_return leave
  #   subject.touch_in(enter)
  #   expect { subject.touch_out(leave)}.to change { subject.balance }.by -4
  # end
  # ******************************************************************************
end
