json.array!(@houses) do |house|
  json.extract! house, :id, :title, :description, :address, :price
  json.url house_url(house, format: :json)
end
