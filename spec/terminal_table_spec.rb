require_relative 'spec_helper.rb'

RSpec.describe RunningTrack::TerminalTable do
  let(:data) { [%w[a b c d], %w[a b c d]] }

  let(:table) do
    column_names = %w[District Address Phone Wifi]
    described_class.new(data, column_names)
  end

  it 'initializes' do
    expect(table.rows).to eq(data)
  end

  it 'creates table for printing' do
    terminal_table = table.send(:terminal_table)
    expect(terminal_table).to be_a_kind_of(Terminal::Table)
    expect(terminal_table.rows.count).to eq(2)
    expect(terminal_table.columns.count).to eq(4)
  end
end
