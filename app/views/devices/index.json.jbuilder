json.array!(@devices) do |device|
  json.extract! device, :id, :os, :model, :code
  json.url device_url(device, format: :json)
end
