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

  it 'creates version for printing' do
    terminal_table = subject.send(:printing_version)
    expect(terminal_table).to be_a_kind_of(Terminal::Table)
    expect(terminal_table.rows.count).to eq(2)
    expect(terminal_table.columns.count).to eq(4)
  end
end
