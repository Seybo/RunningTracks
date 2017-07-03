module RunningTrack
  class Track
    attr_reader :district, :address, :phone, :has_wifi

    @tracks_list = []

    def initialize(district, address, phone, has_wifi)
      @district = district
      @address = address
      @phone = phone
      @has_wifi = has_wifi

      self.class.add_track(self)
    end

    def self.update_tracks(data)
      JSON.parse(data).map! do |row|
        district = row['Cells']['District']
        address = row['Cells']['Address']
        phone = row['Cells']['HelpPhone']
        has_wifi = row['Cells']['HasWifi']

        Track.new(district, address, phone, has_wifi)
      end
    end

    def self.add_track(track)
      @tracks_list << track
    end

    def self.all
      @tracks_list
    end

    def self.find(property, value)
      @tracks_list.select { |track| track.send(property) == value }
    end

    def self.find_random(number)
      return [] if number > @tracks_list.size || number < 1
      @tracks_list.sample(number)
    end

    def to_a
      [@district, @address, @phone, @has_wifi]
    end

    def to_s
      "District: #{@disctrict}.
       Addres: #{@address}.
       Phone: #{@phone}.
       Wi-fi available: #{@has_wifi}"
    end
  end
end
