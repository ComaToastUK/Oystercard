require 'journey'

RSpec.describe Journey do
  subject { described_class.new }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  # it 'knows its entry_station' do
  #
  #   expect(subject.entry_station).to eq entry_station
  # end

  it 'saves the journey_history' do
    subject.start_journey(entry_station)
    subject.end_journey(exit_station)
    current_journey = { entry_station: entry_station, exit_station: exit_station }
    expect(subject.journey_history).to include current_journey
  end
end
