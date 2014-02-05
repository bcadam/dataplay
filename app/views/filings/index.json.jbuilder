json.array!(@filings) do |filing|
  json.extract! filing, :id, :title, :url, :links, :summary, :updated, :categories, :id
  json.url filing_url(filing, format: :json)
end
