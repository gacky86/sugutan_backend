# ログイン状態確認用コントローラー
class Api::V1::Auth::SessionsController < ApplicationController
  def index
    if current_api_v1_user
      render json: { is_login: true, status: 200, data: current_api_v1_user }
    else
      render json: { is_login: false, status: 500, message: 'ユーザーが存在しません' }
    end
  end
end
