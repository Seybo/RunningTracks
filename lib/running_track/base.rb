module RunningTrack
  class Base
    @cache = {}

    def self.get_tracks_data
      @cache[:all_tracks] ||= fetch_data
    end

    def self.fetch_data
      Track.update_tracks(Data.import).map(&:to_a)
    end

    def self.cache
      @cache
    end
  end
end
