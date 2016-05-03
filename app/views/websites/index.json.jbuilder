json.array!(@websites) do |website|
  json.extract! website, :id, :name, :product, :user_id
  json.url website_url(website, format: :json)
end
