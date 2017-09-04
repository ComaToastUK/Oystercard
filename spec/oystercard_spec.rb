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
      expect{ subject.top_up 1 }.to change { subject.balance}.by 1
      end
    end

    describe '#over_limit' do
      it 'raises an error if over limit' do
        message = "Over limit £#{Oystercard::DEFAULT_LIMIT}"
        expect{subject.top_up(Oystercard::DEFAULT_LIMIT)}.to raise_error message
      end
    end

    describe '#deduct' do
      it 'deducts money from balance' do
        subject.top_up(50)
        expect{ subject.instance_eval{ deduct(10) } }.to change { subject.balance }.by -10
      end
    end

    describe '#touch_in' do
      it 'changes the oystercard status of in_use to true' do
        subject.top_up(50)
        expect { subject.touch_in }.to change { subject.in_journey? }.to true
      end
      it "raises_error if under £1" do
        message = 'Insufficient funds'
        expect{subject.touch_in}.to raise_error message
      end
    end

    describe '#touch_out' do
      it 'changes the oystercard status of in_use to false' do
        subject.top_up(50)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.in_journey? }.to false
      end

      it 'changes the balance by minimum' do
        subject.top_up(50)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::DEFAULT_MINIMUM
      end
    end

end
