require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::TerminalTable do
  let(:column_names) { %w[District Address Phone Wifi] }
  let(:data) { [%w[a b c d], %w[a b c d]] }
  subject { RunningTrack::TerminalTable.new(data) }

  it 'assignes columns names' do
    expect(subject.class::HEADINGS).to eq(column_names)
  end

  it 'initializes' do
    expect(subject.rows).to eq(data)
  end

  it 'creates table for printing' do
    table = subject.send(:table)
    expect(table).to be_a_kind_of(Terminal::Table)
    expect(table.rows.count).to eq(2)
    expect(table.columns.count).to eq(4)
  end
end
