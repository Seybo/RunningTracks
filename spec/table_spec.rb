require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::Table do
  let(:column_names) { %w[District Address Phone Wifi] }
  let(:data) { [%w[a b c d], %w[a b c d]] }
  let(:table) { RunningTrack::Table.new(data) }

  it 'assignes columns names' do
    expect(RunningTrack::Table::HEADINGS).to eq(column_names)
  end

  it 'initializes' do
    expect(table.instance_variable_get(:@rows)).to eq(data)
  end

  it 'creates version for printing' do
    terminal_table = table.send(:printing_version)
    expect(terminal_table).to be_a_kind_of(Terminal::Table)
    expect(terminal_table.rows.count).to eq(2)
    expect(terminal_table.columns.count).to eq(4)
  end
end
