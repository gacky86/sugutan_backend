# app/controllers/api/v1/accounts_controller.rb
class Api::V1::AccountsController < ApplicationController
  before_action :authenticate_api_v1_user!

  def update_email
    user = current_api_v1_user

    unless user.valid_password?(email_params[:current_password])
      return render json: { error: "現在のパスワードが正しくありません" },
                    status: :unprocessable_entity
    end

    user.unconfirmed_email = email_params[:email]

    if user.save
      user.send_confirmation_instructions

      render json: {
        message: "確認メールを送信しました。メール内のリンクをクリックしてください。"
      }
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update_password
    user = current_api_v1_user

    unless user.valid_password?(password_params[:current_password])
      return render json: { error: "現在のパスワードが正しくありません" },
                    status: :unprocessable_entity
    end

    if user.update(password_update_params)
      user.tokens = {}
      user.save!

      render json: {
        message: "パスワードを変更しました。再ログインしてください。"
      }
    else
      render json: { errors: user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def withdraw
    user = current_api_v1_user

    unless user.valid_password?(params[:current_password])
      return render json: { error: "現在のパスワードが正しくありません" },
                    status: :unprocessable_entity
    end
    # unless user.valid_password?(withdraw_params[:current_password])
    #   return render json: { error: "現在のパスワードが正しくありません" },
    #                 status: :unprocessable_entity
    # end

    ActiveRecord::Base.transaction do
      user.update!(
        deleted_at: Time.current,
        email: "deleted_#{user.id}@example.com" # 同じメールで再登録できるようにするため
      )

      # トークン無効化（強制ログアウト）
      user.tokens = {}
      user.save!
    end

    render json: { message: '退会しました' }, status: :ok
  end

  private

  def email_params
    params.require(:user).permit(
      :email,
      :current_password
    )
  end

  def password_params
    params.require(:user).permit(
      :current_password,
      :password,
      :password_confirmation
    )
  end

  def password_update_params
    password_params.except(:current_password)
  end
end
