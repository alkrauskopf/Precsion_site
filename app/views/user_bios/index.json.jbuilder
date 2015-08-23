json.array!(@user_bios) do |user_bio|
  json.extract! user_bio, :id, :education, :history, :user_id
  json.url user_bio_url(user_bio, format: :json)
end
