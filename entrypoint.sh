#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /sugutan_backend/tmp/pids/server.pid

# production環境の場合のみ
if [ "$RAILS_ENV" = "production" ]; then
  # railsに含まれる静的ファイルをコンパイルするコマンド（APIモードなので不要）
  # bundle exec rails assets:precompile
  # --------------------------------------
  # 本番環境（AWS ECS）への初回デプロイ時に利用
  # 初回デプロイ後にコメントアウトして下さい
  bundle exec rails db:create
  # --------------------------------------
  # マイグレーション処理
  bundle exec rails db:migrate
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
