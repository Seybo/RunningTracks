FactoryGirl.define do
  factory :track, class: RunningTrack::Track do
    district 'District'
    address 'Address'
    phone 'Phone'
    has_wifi 'Has WiFi'

    initialize_with { new(district, address, phone, has_wifi) }
  end
end
