require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Base do
  it 'returns cache if not expired' do
    described_class.cache[:all_tracks] = [%w[A B C D]]
    described_class.cache[:expiring_at] = DateTime.now + 1.seconds
    expect(described_class.cache[:all_tracks]).to eq [%w[A B C D]]
  end

  it 'empties expired cache' do
    described_class.cache[:all_tracks] = [%w[A B C D]]
    described_class.cache[:expiring_at] = DateTime.now
    expect(described_class.cache).to eq(all_tracks: nil, expiring_at: nil)
  end
end
