Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['omniauth_provider_key'], ENV['omniauth_provider_secret'], scope: 'user_friends, user_birthday, user_education_history', info_fields: 'email,name,first_name,last_name,gender,summary,education'
  # for secrets.yml
  # provider :facebook, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret, scope: 'user_birthday,user_education_history'
end
