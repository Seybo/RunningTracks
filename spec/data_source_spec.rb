require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::DataSource do
  it 'returns tracks data from server' do
    expect(described_class.import).to include('global_id')
  end
end
