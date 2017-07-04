require 'json'
require 'active_support/core_ext/hash/slice'
require 'terminal-table'

module RunningTrack
  class TerminalTable
    attr_reader :rows

    HEADINGS = %w[District Address Phone Wifi].freeze

    def print
      puts table
      puts "#{@rows.count} tracks printed"
    end

    private

    def initialize(tracks_list)
      @rows = tracks_list
    end

    def table
      separators = Array.new(@rows.count - 1) { :separator }
      sep_rows   = @rows.zip(separators).flatten(1).compact
      Terminal::Table.new rows: sep_rows, headings: HEADINGS
    end
  end
end
