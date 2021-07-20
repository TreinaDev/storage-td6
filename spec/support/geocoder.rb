Geocoder.configure(lookup: :test, ip_lookup: :test)

Geocoder::Lookup::Test.set_default_stub(
  [
    {
      'coordinates' => [-23.5672582, -46.651529],
      'address' => 'Alameda Santos, Jardim Paulista, São Paulo',
      'state' => 'São Paulo',
      'state_code' => 'SP',
      'country' => 'Brasil',
      'country_code' => 'BR'
    }
  ]
)
