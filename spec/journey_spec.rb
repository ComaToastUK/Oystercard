require 'journey'

RSpec.describe Journey do
subject {described_class.new("Old Street")}

  it 'knows its entry_station' do
    expect(subject.entry_station).to eq "Old Street"
  end

end
