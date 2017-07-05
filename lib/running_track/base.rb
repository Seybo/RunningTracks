module RunningTrack
  class Base
    @cache = {}

    def self.tracks_data
      return cache[:all_tracks] if cache[:all_tracks]
      json_data = fetch_data
      cache[:all_tracks] = parse_to_tracks_ary(json_data)
    end

    def self.fetch_data
      DataSource.import
    end

    def self.parse_to_tracks_ary(data)
      Track.from_json(data).map(&:to_a)
    end

    class << self
      attr_accessor :cache
    end
  end
end
