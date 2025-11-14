class ApplicationController < ActionController::Base
  include ActionController::Cookies
  include DeviseTokenAuth::Concerns::SetUserByToken

  skip_before_action :verify_authenticity_token
  helper_method :current_user, :user_signed_in?

  def set_auth_cookies(resource, client_id, token)
    cookies.signed[:uid] = {
      value: resource.uid,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    cookies.signed[:client] = {
      value: client_id,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }

    cookies.signed[:access_token] = {
      value: token,
      httponly: true,
      secure: Rails.env.production?,
      same_site: :lax
    }
  end
end
