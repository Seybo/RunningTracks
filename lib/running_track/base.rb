module RunningTrack
  class Base
    CACHE_EXPIRATION = 1.hour

    @cache = {}

    def self.tracks_data
      return cache[:all_tracks] if cache[:all_tracks]
      json_data = fetch_data
      cache[:expiring_at] = DateTime.now + CACHE_EXPIRATION
      cache[:all_tracks] = parse_to_tracks_ary(json_data)
    end

    def self.fetch_data
      DataSource.import
    end

    def self.parse_to_tracks_ary(data)
      Track.from_json(data).map(&:to_a)
    end

    class << self
      attr_writer :cache

      def cache
        if cache_expired?
          @cache[:all_tracks] = nil
          @cache[:expiring_at] = nil
        end
        @cache
      end

      private

      def cache_expired?
        @cache[:expiring_at] && @cache[:expiring_at] < DateTime.now
      end
    end
  end
end
