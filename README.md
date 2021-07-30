## 概要

GoogleAppScript の開発環境  
複数のプロジェクトを同じリポジトリで管理する

```sh
.
├── dist # 実際にデプロイされるファイル群
│   ├── prjA
│   │   └── bundle.js
│   └── prjB
│       ├── bundle.js
│       └── index.html
└── src # 開発時に触るファイル群
    ├── prjA
    │   └── index.js
    └── prjB
        ├── index.js
        └── index.html
```

## 環境構築

node v14
npm v6

1. clone 後、package をインストール

```sh
npm i
```

2. 認証が必要なのでログインする(ブラウザが立ち上がります)

```sh
npx clasp login
```

## 使い方

### 開発

1. `src` 以下のファイルを編集する。
2. デプロイする

```sh
npm run clasp:deploy ${dirName} ${deployId}
```

### 既存プロジェクトからクローン

下記コマンド後、入力受付になるのでプロジェクト名の入力とクローンするプロジェクトを選択。  
**※注意 GAS のプロジェクト名とディレクトリ名を統一すること**
クローンしたコードが`src`配下に作成されます。

```sh
npm run clasp:clone
```

### 注意点

1. webpack の設定上、プロジェクトのスクリプト名は`index.js`で統一
