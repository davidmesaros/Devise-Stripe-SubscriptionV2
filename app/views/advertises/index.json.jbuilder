json.array!(@advertises) do |advertise|
  json.extract! advertise, :id, :description
  json.url advertise_url(advertise, format: :json)
end
