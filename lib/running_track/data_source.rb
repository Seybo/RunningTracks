require 'net/http'

module RunningTrack
  module DataSource
    DATA_URL = 'https://apidata.mos.ru/v1/datasets/899/rows?api_key=268a00fbab5563ccec0faaab8102ce2c'.freeze

    def self.import
      response = Net::HTTP.get_response(URI.parse(DATA_URL))
      raise "#{response.code}: #{response.message}" unless response.code == '200'
      response.body
    end
  end
end
