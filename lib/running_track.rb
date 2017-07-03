require 'pp'
require 'active_support/all'
require_relative 'running_track/base'
require_relative 'running_track/data'
require_relative 'running_track/table'
require_relative 'running_track/track'

module RunningTrack
  def self.print(data)
    Table.new(data).print
    pp "#{data.count} tracks printed"
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
end
