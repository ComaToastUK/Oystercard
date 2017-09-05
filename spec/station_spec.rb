require 'station'

RSpec.describe Station do
  subject { described_class.new('Aldgate', 1) }
  it 'knows station name' do
    expect(subject.name).to eq 'Aldgate'
  end

  it 'knows station zone' do
    expect(subject.zone).to eq 1
  end
end
