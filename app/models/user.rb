# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  # Googleアカウントで登録/ログインするためのメソッド
  # find_or_create_byは条件に合うユーザーがいればそのレコードを返し、居なければ新規登録してそのレコードを返す。
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      # ランダムなパスワードをセット
      user.password = Devise.friendly_token[0, 20]
      # Google users don't need email confirmation
      user.skip_confirmation!
    end
  end
end
