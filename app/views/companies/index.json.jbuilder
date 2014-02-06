json.array!(@companies) do |company|
  json.extract! company, :id, :name, :cik, :industry
  json.url company_url(company, format: :json)
end
