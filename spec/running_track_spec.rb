require_relative 'spec_helper.rb'

RSpec.describe RunningTrack do
  let(:base_class) { RunningTrack::Base }

  before(:each) do
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
    subject.all
    expect(base_class.cache[:all_tracks]).to be_kind_of(Array)
  end

  it 'takes all tracks data from cache' do
    expect(base_class).to_not receive(:fetch_data)
    subject.all
  end

  it 'searches data in cache' do
    build_tracks
    expect(base_class).to_not receive(:fetch_data)

    expect(subject.find_by('district', 'e')).to eq([%w[e e1 1 yes],
                                                         %w[e e2 1 yes]])
  end

  it 'fetches data before search' do
    base_class.cache[:all_tracks] = nil
    expect(base_class).to receive(:fetch_data)

    expect(subject.find_by('district', 'район Крюково').size).to be > 0
  end

  it 'prints data' do
    # you should see it with your eyes
    subject.print(base_class.cache[:all_tracks])
  end
end
