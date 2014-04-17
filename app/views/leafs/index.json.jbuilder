json.array!(@leafs) do |leaf|
  json.extract! leaf, :id, :content
  json.url leaf_url(leaf, format: :json)
end
