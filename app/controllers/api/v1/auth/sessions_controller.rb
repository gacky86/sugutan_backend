class Api::V1::Auth::SessionsController < DeviseTokenAuth::SessionsController
  include ActionController::Cookies
  before_action :validate_check, only: :create

  # def validate_token
  #   if current_api_v1_user
  #     render json: {
  #       is_login: true,
  #       data: current_api_v1_user
  #     }
  #   else
  #     render json: { is_login: false }, status: :unauthorized
  #   end
  # end

  def create
    super do |resource|
      if resource&.valid?
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

  protected

  def validate_check
    email = params[:email]
    password = params[:password]

    # 使用不可能な文字がメールアドレス及びパスワードに含まれていないこと
    # ただし、パスワードやメアドの条件を不正ログインに開示しないようにするため、メッセージは「メールアドレスまたはパスワードが違います」に固定。
    render json: { error: "メールアドレスまたはパスワードが違います" }, status: :unprocessable_entity if contains_invalid_email_chars?(email)
    render json: { error: "メールアドレスまたはパスワードが違います" }, status: :unprocessable_entity if contains_invalid_password_chars?(password)
  end

  def render_create_error_bad_credentials
    render json: { error: "メールアドレスまたはパスワードが違います" }, status: :unauthorized
  end

  private

  def contains_invalid_email_chars?(value)
    invalid_pattern = /[^a-zA-Z0-9@\.\_\-]/
    value.match?(invalid_pattern)
  end

  def contains_invalid_password_chars?(value)
    invalid_pattern = /[^a-zA-Z0-9\_]/
    value.match?(invalid_pattern)
  end
end
