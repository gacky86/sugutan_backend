class Api::V1::Auth::OmniauthCallbacksController < DeviseTokenAuth::OmniauthCallbacksController
  def redirect_callbacks
    auth = request.env['omniauth.auth'] # googleから認証情報を取得
    return if auth.nil?

    # request.env['omniauth.auth']にリクエストパラメータのユーザー情報が入ってくる
    user = User.from_omniauth(request.env['omniauth.auth'])

    # persisted? : DBに登録ずみか？
    if user.persisted?
      # create_new_auth_tokenでトークン情報を全て生成する
      token = user.create_new_auth_token
      if user.save
        # cookie に token を保存
        set_auth_cookies(token, user)
        # redirect_to "http://localhost:5173?status=success&access-token=#{token['access-token']}&uid=#{user.uid}&client=#{token['client']}&expiry=#{token['expiry']}"
        # フロントエンドのリダイレクト（statusやexpiryをどうするかは検討中）
        redirect_to redirect_url
      end
    else
      render json: { status: 'ERROR', message: '401 Unauthorized', data: user.errors }, status: :unprocessable_entity
    end
  end

  private

  # Cookie にトークンを保存
  def set_auth_cookies(token, user)
    cookies[:uid]          = { value: user.uid, httponly: true, secure: Rails.env.production?, same_site: :lax }
    cookies[:client]       = { value: token["client"], httponly: true, secure: Rails.env.production?, same_site: :lax }
    cookies[:access_token] =
      { value: token["access-token"], httponly: true, secure: Rails.env.production?, same_site: :lax }
  end

  # フロントのURLを返す
  def redirect_url
    ENV['FRONTEND_HOST'] || "http://localhost:5173"
  end
end
