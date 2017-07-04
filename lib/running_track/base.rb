module RunningTrack
  class Base
    @cache = {}

    def self.tracks_data
      @cache[:all_tracks] ||= fetch_data
    end

    def self.fetch_data
      Track.update_tracks(DataSource.import).map(&:to_a)
    end

    class << self
      attr_reader :cache
    end
  end
end
