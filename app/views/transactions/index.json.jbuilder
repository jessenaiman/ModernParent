json.array!(@finances) do |finance|
  json.extract! finance, :id
  json.url finance_url(finance, format: :json)
end
