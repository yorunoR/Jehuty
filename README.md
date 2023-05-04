# Jehuty

## 開発環境
※ docker を使います。

### 事前準備
環境変数を設定してください。

* フロントエンド
`web/.env.development.sample` を参考に `web/.env.development` を作成してください。  
主に firebase 用の設定になります。

* バックエンド
`.env.sample` を参考に `.env` を作成してください。

### 起動
`docker compose up` してください。

http://localhost:8080/ でアプリケーション画面が開けます。  
http://localhost:3000/admin/ で管理画面が開けます。
