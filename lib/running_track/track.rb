require_relative 'track/states'

module RunningTrack
  class Track
    include States

    PROPERTIES = %w[district address phone has_wifi].freeze

    attr_reader(*PROPERTIES)

    @tracks_list = []

    def initialize(args)
      @district = args[:district]
      @address = args[:address]
      @phone = args[:phone]
      @has_wifi = args[:has_wifi]

      self.class.add_track(self)
    end

    def to_a
      [district, address, phone, has_wifi]
    end

    def to_s
      "District: #{district}.
       Address: #{address}.
       Phone: #{phone}.
       WiFi: #{has_wifi}"
    end

    class << self
      attr_accessor :tracks_list

      def from_json(data)
        JSON.parse(data).map! do |row|
          t = row['Cells']
          new(district: t['District'], address: t['Address'],
              phone: t['HelpPhone'], has_wifi: t['HasWifi'])
        end
      end

      def add_track(track)
        tracks_list << track
      end

      def find_by(property:, value:)
        return "No such property: #{property}" unless property.in?(PROPERTIES)
        tracks_list.select { |track| track.public_send(property) == value }
      end

      def find_random(number)
        return [] if number > tracks_list.size || number < 1
        tracks_list.sample(number)
      end
    end
  end
end
