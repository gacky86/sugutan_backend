class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  include ActionController::Cookies

  def create
    super do |resource|
      if resource && resource.valid?
        client_id = @token.client
        token = @token.token

        set_auth_cookies(resource, client_id, token)
      end
    end
  end

  def destroy
    cookies.delete(:uid)
    cookies.delete(:client)
    cookies.delete(:access_token)
    super
  end
end
