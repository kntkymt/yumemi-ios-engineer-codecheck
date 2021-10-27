# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

株式会社ゆめみ インターン iOS提出課題

課題リポジトリ: https://github.com/yumemi-inc/ios-engineer-codecheck

## アプリ仕様・動作・説明

本アプリはGitHubのリポジトリを検索するアプリです。

- iOS15以上
- iPhoneのみ, 画面回転非対応

| 検索ホーム | 検索 | 詳細1 | 詳細2 |
| ------ | ------ | ------ | -----
| ![](./README_images/Home.png) | ![](./README_images/Search.png)  | ![](./README_images/Detail.png) |![](./README_images/Detail_Readme.png)  |

### 検索ホーム
- アプリを開いた直後の画面
- 各セルには`所有者のアイコン`, `所有者名`, `リポジトリ名`, `説明`, `スター数`, `言語`を表示
- App StoreアプリのToday画面やGitHubアプリを参考にレイアウトを作成
- ナビゲーションの検索バーに文字を入れ検索することで検索結果を表示
- セルをタップすることで詳細画面に遷移

### 検索
- 検索結果を表示
- セルをタップすることでリポジトリ詳細画面に遷移

### 詳細
- 見出し, カウント, Readmeの3部分によって構成
- 見出し: `所有者のアイコン`, `所有者名`, `リポジトリ名`, `説明`, `言語`を表示
- カウント: `スター数`, `Watchers数`, `Fork数`, `Issue数`を表示
- Readme: リポジトリの`Readme.md`を表示
    - 現状、画像埋め込みや相対パスによるリンク参照は押しても何も起きません(実装が難しかったため)
    - URLによる画像埋め込み・絶対パスによるリンク参照・外部リンクは動作します
- 全体的にGitHubアプリのリポジトリ詳細画面を参考にレイアウトを作成

## その他
- 全画面ダークモードに対応
- 検索画面と詳細画面Readmeがロード中は`UIActivityIndicator`でロード中表示
- エラーが発生した場合はバナーでメッセージを表示

|  |  | |
| ------ | ------ | ------- |
|  |  | |

## セットアップ方法

特になし。

ライブラリは全て`Swift Package Manager`を用いて導入しているため、`.xcodeproj`を開くと自動でダウンロードされます。

## 設計思想・アーキテクチャ


細かい設計については `アーキテクチャ`のラベルがついたPRの説明欄をご覧ください。

## 課題について

- 各PRに関係する課題をラベルとしてつけてあります。課題部分の変更を確認したい場合は以下を参考にPRをご覧ください。

| 課題名 | 対応するラベル |
| ------ | ------ |
| [ソースコードの可読性の向上](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/2) | ソースコードの可読性の向上 |
| [ソースコードの安全性の向上](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/3) | ソースコードの安全性の向上 |
| [バグを修正](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/4) | バグを修正 |
| [FatVCの回避](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/5), [アーキテクチャを適用](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/7), [プログラム構造をリファクタリング](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/6) | アーキテクチャ |
| [テストを追加](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/10) | テスト |
| [UIをブラッシュアップ](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/8), [新機能を追加](https://github.com/yumemi-inc/ios-engineer-codecheck/issues/9) | UIUX新機能  |