json.array!(@fuels) do |fuel|
  json.extract! fuel, :id, :fuel_type, :price, :site_id
  json.url fuel_url(fuel, format: :json)
end
