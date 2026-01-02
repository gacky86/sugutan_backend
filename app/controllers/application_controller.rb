class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies

  before_action :set_token_headers_from_cookies, :set_locale

  private

  # Cookie → Request Header に移す
  def set_token_headers_from_cookies
    return if request.headers['access-token'].present?

    if cookies[:access_token].present? && cookies[:client].present? && cookies[:uid].present?
      request.headers['access-token'] = cookies[:access_token]
      request.headers['client']       = cookies[:client]
      request.headers['uid']          = cookies[:uid]
    end
  end

  def set_auth_cookies(resource, client_id, token)
    cookies[:uid] = {
      value: resource.uid,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    cookies[:client] = {
      value: client_id,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    cookies[:access_token] = {
      value: token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }
  end

  def set_locale
    # ヘッダーから言語を取得し、対応していなければデフォルト(ja)を使用
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
  end
end
