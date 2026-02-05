こちらは「スグ単」のバックエンドのリポジトリです。フロントエンドのリポジトリは[こちら](https://github.com/gacky86/sugutan_frontend)です。インフラのリポジトリは[こちら](https://github.com/gacky86/sugutan_infra)です。

# スグ単/AI辞書機能付き単語帳
画像をここに挿入

## サービス概要
スグ単は「英語学習中に調べた表現を後で復習して使えるようにしたい！」という想いから作られた、AI辞書機能付き単語帳アプリです。

AI辞書機能で和英・英和の両方で検索でき、検索結果はその場で作成済みの単語帳に登録できます。
単語帳に登録したカードは学習機能で復習することができます。

### ▼ サービスURL
https://sugutan.site/

レスポンシブ対応済のため、PCでもスマートフォンでも快適にご利用いただけます。

### ▼ 紹介記事(Qiita)

[]()

開発背景や、サービスのリリースまでに勉強したことなどをまとめています。

## メイン機能の使い方
gif画像を使って説明する
単語帳の作成
単語の検索と登録
学習

## 使用技術一覧

**バックエンド:** Ruby 3.2.2 / Rails 7.0.7.2

- コード解析 / フォーマッター: Rubocop
- テストフレームワーク: RSpec

**フロントエンド:** TypeScript 5.0.2 / React 18.2.0

- コード解析: ESLint
- フォーマッター: Prettier
- テストフレームワーク: Vitest / React Testing Library
- CSSフレームワーク: Tailwind CSS
- 主要パッケージ: Axios / Font Awesome / React Paginate / React Responsive Modal / React Toastify

**インフラ:** AWS(Route53 / Certificate Manager / Cloud Front / S3 / ALB / VPC / ECR / ECS Fargate / RDS PostgresSQL) 

**CI / CD:** GitHub Actions

**環境構築:** Docker / Docker Compose 

**認証:** Devise / devise-token-auth

## 主要対応一覧

### ユーザー向け

#### 機能

- メールアドレスとパスワードを利用したユーザー登録 / ログイン機能
- ユーザー情報変更機能
- パスワード再設定機能
- 退会機能
- 単語帳の取得 / 作成 / 更新 / 削除機能
- AIを用いた英和・和英辞書機能
- 辞書検索結果から単語帳への単語カード登録機能
- 単語カードの取得 / 作成 / 更新 / 削除機能

#### 画面

- トースト表示
- ローディング画面
- モーダル画面
- 404 / 500エラーのカスタム画面
- レスポンシブデザイン

### 非ユーザー向け

#### システム / インフラ

- Dockerによる開発環境のコンテナ化
- Route53による独自ドメイン + SSL化
- GitHub ActionsによるCI / CDパイプラインの構築
  - バックエンド
    - CI: Rubocop / RSpec
    - CD: AWS ECS
  - フロントエンド
    - CI: ESLint / Prettier / Vitest / Codecov
    - CD: S3 / Cloud Front
- TerraformによるインフラのIaC化


## インフラ構成図


## ER図



## 画面遷移図
