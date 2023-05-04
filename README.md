# Jehuty

いろいろ実験用 AI Chat App

## 開発環境
※ docker を使います。

### 事前準備

#### 環境変数

* フロントエンド  
`web/.env.development.sample` を参考に `web/.env.development.local` を作成してください。  
主に firebase 用の設定になります。

* バックエンド  
`.env.sample` を参考に `.env` を作成してください。

#### Chrome & Chromedriver

`api/containers/development/Dockerfile` 内のバージョンを最新のものにしてください。

### 起動

起動
```
docker compose up
```

データベースセットアップ
```
docker compose exec api mix setup
```

http://localhost:8080/ でアプリケーション画面が開けます。  
http://localhost:3000/admin/ で管理画面が開けます。
