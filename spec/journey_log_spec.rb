require 'journey_log'
require 'oystercard'
require 'journey'

RSpec.describe Journey_log do
  subject { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }
  it 'saves the journey_history' do
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    subject.log(current_journey)
    expect(subject.journey_log).to include current_journey
  end

  it 'prints the journey_log' do
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    subject.log(current_journey)
    expect(subject.print_log).to eq [current_journey]
  end
end
