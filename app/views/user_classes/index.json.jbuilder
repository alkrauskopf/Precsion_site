json.array!(@user_classes) do |user_class|
  json.extract! user_class, :id, :abbrev, :name, :description
  json.url user_class_url(user_class, format: :json)
end
