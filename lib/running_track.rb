require 'active_support/all'
require_relative 'running_track/base'
require_relative 'running_track/data_source'
require_relative 'running_track/terminal_table'
require_relative 'running_track/track'
require_relative 'running_track/file_storage'

module RunningTrack
  def self.print(data)
    TerminalTable.new(data).print
  end

  def self.all
    Base.tracks_data
  end

  def self.find_by(property, value)
    Base.fetch_data unless Base.cache[:all_tracks]
    Track.find(property, value).map(&:to_a)
  end

  def self.find_random(number)
    Track.find_random(number)
  end

  def self.save(tracks_list)
    FileStorage.yaml_save(tracks_list)
  end

  def self.load
    FileStorage.yaml_load
  end
end
