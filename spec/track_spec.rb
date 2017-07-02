require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Track do
  let(:tracks_list) { RunningTrack::Track.instance_variable_get :@tracks_list }
  let(:default_track) { build(:track) }
  let(:track1) { build(:track, district: 'new district', address: 'new address',
                               phone: 'new phone', has_wifi: 'no') }
  let(:track2) { build(:track, district: 'new district') }

  before(:each) do
    RunningTrack::Track.instance_variable_set :@tracks_list, []
  end

  it 'represents a track as an array' do
    expect(default_track.to_a).to eq(['District', 'Address', 'Phone', 'Has WiFi'])
  end

  it 'updates all tracks list' do
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
    expect(RunningTrack::Track.find('district', 'District').count).to eq 0
    track2
    expect(RunningTrack::Track.find('district', 'new district').count).to eq 2
  end
end
