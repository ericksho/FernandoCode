json.array!(@products) do |product|
  json.extract! product, :codeText, :codeNumber, :description
  json.url product_url(product, format: :json)
end
