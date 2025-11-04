# アカウント作成用コントローラー
# 継承元も変更するので注意
class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.permit(:email, :password, :password_confirmation, :name)
  end
end
