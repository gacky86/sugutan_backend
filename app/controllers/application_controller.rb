class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ActionController::Cookies

  before_action :set_token_headers_from_cookies

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
end
