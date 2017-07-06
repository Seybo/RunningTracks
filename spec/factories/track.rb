FactoryGirl.define do
  factory :track, class: RunningTrack::Track do
    district 'District'
    address 'Address'
    phone 'Phone'
    has_wifi 'Has WiFi'

    initialize_with do
      new(district: district, address: address,
          phone: phone, has_wifi: has_wifi)
    end
  end
end
