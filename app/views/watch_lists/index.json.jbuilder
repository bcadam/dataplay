json.array!(@watch_lists) do |watch_list|
  json.extract! watch_list, :id, :name
  json.url watch_list_url(watch_list, format: :json)
end
