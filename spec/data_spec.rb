require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Data do
  it 'returns tracks data from server' do
    expect(subject.import).to include('global_id')
  end
end
