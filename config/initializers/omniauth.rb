require 'omniauth'

OmniAuth.config.silence_get_warning = true # getリクエストの時の警告を無くす
# credentials.yml.encの内容を参照して承認する
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
           Rails.application.credentials.google[:client_id],
           Rails.application.credentials.google[:client_secret]
end
OmniAuth.config.allowed_request_methods = %i[get post]
