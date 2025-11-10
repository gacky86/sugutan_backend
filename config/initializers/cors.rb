Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # 開発環境の場合は、全てのオリジンからのリクエストを許可する
    # 本番環境では取得したドメインからのみ許可する
    if Rails.env.development?
      origins 'http://localhost:5173'
    else
      origins "example.com"
    end
    resource '*', # すべてのエンドポイントに適用
      headers: :any, # すべてのヘッダーを許可
      expose: ["access-token", "expiry", "token-type", "uid", "client"],
      methods: [:get, :post, :put, :patch, :delete, :options, :head], # 許可するHTTPメソッドを定義
      credentials: true
  end
end
