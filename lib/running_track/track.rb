require 'aasm'

module RunningTrack
  class Track
    include AASM

    attr_reader :district, :address, :phone, :has_wifi

    @tracks_list = []

    aasm do
      state :unknown, initial: true
      state :good, :normal, :bad

      event :good do
        transitions from: :unknown, to: :good
      end

      event :normal do
        transitions from: :unknown, to: :normal
      end

      event :bad do
        transitions from: :unknown, to: :bad
      end
    end

    def initialize(district, address, phone, has_wifi)
      @district = district
      @address = address
      @phone = phone
      @has_wifi = has_wifi

      self.class.add_track(self)
    end

    def to_a
      [@district, @address, @phone, @has_wifi]
    end

    def to_h
      {
        district: district,
        address: address,
        phone: phone,
        has_wifi: has_wifi
      }
    end

    def to_s
      "District: #{@disctrict}.
       Addres: #{@address}.
       Phone: #{@phone}.
       Wi-fi available: #{@has_wifi}"
    end

    class << self
      attr_reader :tracks_list

      def update_tracks(data)
        JSON.parse(data).map! do |row|
          district = row['Cells']['District']
          address = row['Cells']['Address']
          phone = row['Cells']['HelpPhone']
          has_wifi = row['Cells']['HasWifi']

          Track.new(district, address, phone, has_wifi)
        end
      end

      def import_tracks(tracks)
        tracks.each do |track|
          Track.new(track[:district], track[:address], track[:phone], track[:has_wifi])
        end
      end

      def add_track(track)
        @tracks_list << track
      end

      def all
        @tracks_list
      end

      def find(property, value)
        @tracks_list.select { |track| track.send(property) == value }
      end

      def find_random(number)
        return [] if number > @tracks_list.size || number < 1
        @tracks_list.sample(number)
      end
    end
  end
end
