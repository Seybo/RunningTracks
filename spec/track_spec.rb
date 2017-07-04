require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Track do # rubocop:disable Metrics/BlockLength
  let(:default_track) { build(:track) }
  let(:tracks_list) { described_class.tracks_list }

  let(:track1) do
    build(:track, district: 'new district', address: 'new address',
                  phone: 'new phone', has_wifi: 'no')
  end

  let(:track2) { build(:track, district: 'new district') }

  let(:hashed_tracks) do
    [{ district: '1a',
       address: '2a',
       phone: '3a',
       has_wifi: '4a' },
     { district: '1b',
       address: '2b',
       phone: '3b',
       has_wifi: '4b' }]
  end

  before(:each) do
    described_class.instance_variable_set(:@tracks_list, [])
  end

  it 'represents a track as an array' do
    expect(default_track.to_a).to eq(['District', 'Address', 'Phone', 'Has WiFi'])
  end

  it 'represents a track as a hash' do
    hashed = {
      district: 'District',
      address: 'Address',
      phone: 'Phone',
      has_wifi: 'Has WiFi'
    }
    expect(default_track.to_h).to eq(hashed)
  end

  it 'updates tracks_list' do
    default_track
    expect(tracks_list.size).to eq 1

    track1
    expect(tracks_list.size).to eq 2

    last_track = tracks_list.last
    expect(last_track.district).to eq 'new district'
    expect(last_track.address).to eq 'new address'
    expect(last_track.phone).to eq 'new phone'
    expect(last_track.has_wifi).to eq 'no'
  end

  it 'performes search' do
    track1
    expect(described_class.find('district', 'District').count).to eq 0
    track2
    expect(described_class.find('district', 'new district').count).to eq 2
  end

  it 'imports array of hashed tracks' do
    described_class.import_tracks(hashed_tracks)
    expect(described_class.tracks_list.size).to eq hashed_tracks.size
  end

  context 'states' do
    it 'has default' do
      expect(default_track.aasm.current_state).to eq :unknown
    end

    it 'has all' do
      expect(default_track.aasm.states).to eq %i[unknown good normal bad]
    end
  end
end
