require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Track do # rubocop:disable Metrics/BlockLength
  let(:default_track) { build(:track) }
  let(:tracks_list) { described_class.tracks_list }

  let(:track1) do
    build(:track, district: 'new district', address: 'new address',
                  phone: 'new phone', has_wifi: 'no')
  end

  let(:track2) { build(:track, district: 'new district') }

  before(:each) do
    described_class.instance_variable_set(:@tracks_list, [])
  end

  it 'represents a track as an array' do
    expect(default_track.to_a).to eq(['District', 'Address', 'Phone', 'Has WiFi'])
  end

  it 'represents a track as a string' do
    expect(default_track.to_s).to include("District: #{default_track.district}")
    expect(default_track.to_s).to include("Address: #{default_track.address}")
    expect(default_track.to_s).to include("Phone: #{default_track.phone}")
    expect(default_track.to_s).to include("WiFi: #{default_track.has_wifi}")
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

  it 'performes search with correct property' do
    track1
    expect(described_class.find_by(property: 'district', value: 'District').count).to eq 0
    track2
    expect(described_class.find_by(property: 'district', value: 'new district').count).to eq 2
  end

  it 'returns error if search with INcorrect property' do
    track1
    error = 'No such property: not_a_property'
    expect(described_class.find_by(property: 'not_a_property', value: 'search')).to eq error
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
