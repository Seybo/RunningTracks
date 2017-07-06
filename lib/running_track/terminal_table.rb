require 'json'
require 'active_support/core_ext/hash/slice'
require 'terminal-table'

module RunningTrack
  class TerminalTable
    attr_reader :rows, :headings

    def print
      puts terminal_table
      puts "#{rows.count} rows printed"
    end

    private

    def initialize(args)
      @rows = args[:rows]
      @headings = args[:headings]
    end

    def terminal_table
      separators = Array.new(rows.count - 1) { :separator }
      sep_rows   = rows.zip(separators).flatten(1).compact
      Terminal::Table.new rows: sep_rows, headings: headings
    end
  end
end
