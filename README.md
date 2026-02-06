こちらは「スグ単」のバックエンドのリポジトリです。フロントエンドのリポジトリは[こちら](https://github.com/gacky86/sugutan_frontend)です。インフラのリポジトリは[こちら](https://github.com/gacky86/sugutan_infra)です。

# スグ単/AI辞書機能付き単語帳
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
https://github.com/gacky86/sugutan_frontend/blob/main/public/demo/20260206_0.gif
単語の検索と登録
学習
<table>
  <tr>
     <th style="text-align: center">単語帳作成</th>
    <th style="text-align: center">AI単語帳検索＆単語カード登録</th>
    <th style="text-align: center">単語カード学習</th>
  </tr>
  <tr>
    <td><img src="https://raw.githubusercontent.com/gacky86/sugutan_frontend/main/public/demo/20260206_0.gif" alt="単語帳作成" width="250" /></td>
    <td><img src="https://raw.githubusercontent.com/gacky86/sugutan_frontend/main/public/demo/20260206_1.gif" alt="AI辞書検索" width="250" /></td>
    <td><img src="https://raw.githubusercontent.com/gacky86/sugutan_frontend/main/public/demo/20260206_2.gif" alt="単語カード学習" width="250" /></td>
  </tr>
  <tr>
    <td>まずは、単語帳作成ボタンを押して、タイトルと単語帳の概要を記入後に作成ボタンを押す。</td>
    <td>次に、AI辞書機能で知りたい表現を検索する。検索結果を登録するには登録先の単語帳を選択し、単語カード追加ボタンを押す。</td>
    <td>単語帳を開き、Inputモードで学習（またはOutputモードで学習）を押すと、復習を開始できる。</td>
  </tr>
</table>

## 使用技術一覧

**バックエンド:** Ruby 3.1.2 / Rails 7.1.5.2

- コード解析 / フォーマッター: Rubocop
- テストフレームワーク: RSpec

**フロントエンド:** TypeScript 5.9.3 / React 19.1.1

- コード解析: ESLint
- フォーマッター: Prettier
- テストフレームワーク: Vitest / React Testing Library
- CSSフレームワーク: Tailwind CSS
- 主要パッケージ: Axios / React Icons / React router dom / motion / React redux / React Toastify

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
    - CI: ESLint / Prettier / Vitest
    - CD: S3 / Cloud Front
- TerraformによるインフラのIaC化


## インフラ構成図


## ER図
<img src="https://raw.githubusercontent.com/gacky86/sugutan_frontend/main/public/images/ER_diagram.png" alt="ER diagram" />


## 画面遷移図
[Figma_画面遷移図](https://www.figma.com/design/2fsBW9wfbCiC3gmISAJgCd/%E5%8D%98%E8%AA%9E%E5%B8%B3%E3%82%A2%E3%83%97%E3%83%AA_%E3%83%AF%E3%82%A4%E3%83%A4%E3%83%BC%E3%83%95%E3%83%AC%E3%83%BC%E3%83%A0?node-id=0-1&m=dev&t=z3jLNfVkQx4a8r8B-1)
