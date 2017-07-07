require_relative 'spec_helper.rb'

RSpec.describe RunningTrack do # rubocop:disable Metrics/BlockLength
  let(:base_class) { RunningTrack::Base }

  before(:each) do
    described_class::Track.instance_variable_set(:@tracks_list, [])
    base_class.cache[:all_tracks] = [%w[a b c d], %w[e f g h]]
  end

  let(:build_tracks) do
    build(:track, district: 'a')
    build(:track, district: 'b')
    build(:track, district: 'e', address: 'e1', phone: '1', has_wifi: 'yes')
    build(:track, district: 'e', address: 'e2', phone: '1', has_wifi: 'yes')
  end

  it 'fetches all tracks data into cache' do
    base_class.cache[:all_tracks] = nil
    described_class.all
    expect(base_class.cache[:all_tracks]).to be_kind_of(Array)
  end

  it 'takes all tracks data from cache' do
    expect(base_class).to_not receive(:fetch_data)
    described_class.all
  end

  it 'searches data in cache' do
    build_tracks
    expect(base_class).to_not receive(:fetch_data)

    expect(described_class.find_by('district', 'e')).to eq([%w[e e1 1 yes],
                                                            %w[e e2 1 yes]])
  end

  it 'fetches data before search' do
    base_class.cache[:all_tracks] = nil

    expect(described_class.find_by('district', 'район Крюково').size).to be > 0
  end

  it 'returns random tracks' do
    build_tracks
    expect(described_class.find_random(2).size).to eq(2)
    expect(described_class.find_random(5).size).to eq(0)
  end

  it 'prints data' do
    # you should see it with your eyes
    described_class.print(base_class.cache[:all_tracks])
  end

  it 'saves and reads tracks data to/from YAML' do
    build_tracks
    last_track = build(:track, district: '1', address: '2', phone: '3', has_wifi: '4')

    described_class.save(RunningTrack::Track.tracks_list)
    described_class.load
    expect(described_class::Track.tracks_list.size).to eq 5
    expect(described_class::Track.tracks_list.last).to eq last_track
  end
end
