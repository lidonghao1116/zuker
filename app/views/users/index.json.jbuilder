json.array!(@users) do |user|
  json.extract! user, :id, :name, :phone_number, :password, :password_digest, :email
  json.url user_url(user, format: :json)
end
