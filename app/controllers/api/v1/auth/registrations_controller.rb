# アカウント作成用コントローラー
# 継承元も変更するので注意
class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    # ユーザー作成前チェック
    # 使用不可能な文字がメールアドレス及びパスワードに含まれていないこと
    if contains_invalid_email_chars?(sign_up_params[:email])
      return render json: { error: "メールアドレスに使用できない文字が含まれています" }, status: :unprocessable_entity
    end
    if contains_invalid_password_chars?(sign_up_params[:password])
      return render json: { error: "パスワードに使用できない文字が含まれています" }, status: :unprocessable_entity
    end
    # 登録済みメールアドレスでないこと
    # => Userモデルのバリデーションでチェックしているが、エラーメッセージの日本語化対応が面倒なので前段で対応
    if email_already_taken?(sign_up_params[:email])
      return render json: { error: "このメールアドレスは既に登録されています" }, status: :unprocessable_entity
    end

    # パスワードとパスワード（確認用）が一致していること
    if params[:password] != params[:password_confirmation]
      return render json: { error: "パスワードと確認用パスワードが一致しません" }, status: :unprocessable_entity
    end

    super
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

  def email_already_taken?(email)
    User.exists?(email: email.downcase)
  end

  def sign_up_params
    params.require(:registration).permit(:email, :password, :password_confirmation)
  end
end
