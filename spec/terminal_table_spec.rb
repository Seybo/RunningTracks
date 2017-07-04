require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::TerminalTable do
  let(:column_names) { %w[District Address Phone Wifi] }
  let(:data) { [%w[a b c d], %w[a b c d]] }
  let(:table) { described_class.new(data) }

  it 'assignes columns names' do
    expect(described_class::HEADINGS).to eq(column_names)
  end

  it 'initializes' do
    expect(table.rows).to eq(data)
  end

  it 'creates table for printing' do
    created_table = table.send(:table)
    expect(created_table).to be_a_kind_of(Terminal::Table)
    expect(created_table.rows.count).to eq(2)
    expect(created_table.columns.count).to eq(4)
  end
end
