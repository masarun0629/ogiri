# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## users テーブル

| Column             | Type   | Options                 |
| ------------------ | ------ | ------------------------|
| nickname           | string | null: false             |
| email              | string | null: false unique: true|
| encrypted_password | string | null: false             |
| profile            | text   | null: false             |

- has_many :questions
- has_many :answers
- has_many :likes

## questions テーブル

| Column             | Type      | Options                       |
| ------------------ | ----------| ------------------------------|
| question           | string    | null: false                   |
| user               | references| null: false, foreign_key: true|

- belongs_to :user
- has_many   :answers

## answers テーブル

| Column             | Type      | Options                       |
| ------------------ | ----------| ------------------------------|
| answer             | string    | null: false                   |
| user               | references| null: false, foreign_key: true|
| question           | references| null: false, foreign_key: true|

- belongs_to :user
- belongs_to :question
- has_many   :likes

## likes テーブル

| Column             | Type      | Options                       |
| ------------------ | ----------| ------------------------------|
| user               | references| null: false, foreign_key: true|
| answer             | references| null: false, foreign_key: true|

- belongs_to :user
- belongs_to :answer

# アプリケーション名
大喜利掲示板
# アプリケーション概要
大喜利のお題を投稿したり、投稿されたお題に回答したりできる掲示板。
# URL

# 利用方法
## 目標投稿
1.一覧ページのヘッダーから新規登録を行いログインする。

2.ヘッダーのお題投稿ページに遷移してお題を入力。入力し終えたら投稿するボタンを押す。

3.回答する際は、答えたいお題に付随している"回答ページへ"というボタンをクリックする。

4.回答ページへ遷移したらお題の下にあるフォームから回答を投稿する。

## 回答を評価する
1.回答ページの右側にある回答一覧からお気に入りの回答があったらお気に入りボタンを押す。

2.ユーザーは一つの回答に対して一つのハートをあげることができる。

# アプリケーションを作成した背景	
コロナ禍の昨今、自宅での生活の時間が増えた世の中の人たちはボキャブラリーに飢えていると思われる。そこでほんの少しの息抜きとして15分程度の休憩時間でサクッとできるボキャブラリーに富んだ大喜利掲示板というアプリを作りたいと思った。そしてどうせ作るなら少しでもユーザーに張り合いや目的を持ってもらうべく、自信が回答したお題の面白さを評価してもらえる機能や面白さを極めたい人のためにランキング機能も実装することにした。
# 洗い出した要件

https://docs.google.com/spreadsheets/d/10NFWHjbY-MUN0hTN2wmji473_GUbEuUAP9_s-5DQYDU/edit#gid=982722306

# データベース設計
[![Image from Gyazo](https://i.gyazo.com/a4436c38389db3b77cfbbe3e7a6dcb20.png)](https://gyazo.com/a4436c38389db3b77cfbbe3e7a6dcb20)
# 画面遷移図
[![Image from Gyazo](https://i.gyazo.com/563d1b5f24884c159d9b8b2ee181aa65.png)](https://gyazo.com/563d1b5f24884c159d9b8b2ee181aa65)
# 開発環境
Ruby/Ruby on Rails/MySQL/Github/AWS/Visual Studio Code

# 工夫したポイント
まず、大前提として気軽に休憩時間や隙間時間にできるアプリを作ることを目的として開発を始めました。そのためには見やすいビュー、わかりやすい機能などが必須条件だと感じていました。

その点で工夫したことは基本的なことかもしれませんが全ての要素を規則正しく並べたり、背景を淡いカラーにして目が疲れないようにしたりすることでユーザーがそのアプリに入り込みやすいようにしました。また、その一方で非常に地味な作業でしたがこだわった点もたくさんありました。

まず投稿されたお題や回答などは枠の中心から表示されるようにしたり、フォームで施した改行などはそのまま表示されるようにしました。こうすることで内容がより際立つようにしました。非常に地味かもしれませんが、ただ文章をそのまま枠の端から端までそのまま表示したのとでは仕上がりは雲泥の差だと思います。こうした地味な作業はユーザーに快適に使ってもらうには非常に大切だと思います。

また、もう一つこだわった点としてはランキング機能やいいね機能などをつけて競争心を煽り大喜利の醍醐味であるおもしろい回答を目指してもらえるようにしたことです。そのために、まず回答数が多いお題順に並び替えができるようにしました。そうすることによって盛り上がっているお題のページにいきやすくなります。回答数が多いということは激戦区なので当然おもしろい回答も生まれやすくなります。そしてお題の回答一覧にもいいね数のランキングを作ることにしました。そうすることにより先ほどよりもさらにランキング上位を目指しておもしろい回答が生まれやすくなります。これこそが、大喜利の醍醐味だと思うのでその点はユーザー目線に立って非常に工夫しました。

しかしそこで新たに出てくる問題は、人気のお題に回答が集中してしまう点とランキング上位の回答に高評価が集中してしまう点です。それはある意味大喜利の醍醐味でもあるので悪いことではないのですが、あまりに偏りがあっては掲示板の意味を成しません。そこでちょっとした工夫をしました。それぞれお題と回答を投稿した際やアプリを開いた際に、デフォルトで新規順に並ぶようにしたことです。こうすることによりどんなお題や回答も一度は他のユーザーの目に留まるようにしました。また、投稿したユーザーはしっかりと投稿されているか一眼で確認することもできます。こうして自分の投稿や他の人の投稿が一度は目に留まってこそ掲示板としての意味を成すと思います。

あとは、細かいですがお題や回答にはあえて編集機能はつけていません。なぜなら大喜利でこれをやってしまうとなんでもありになってしまうからです。最低限削除機能はつけたので、基本的には変更したい場合などは一度削除してもらう格好になります。

以上を工夫した結果、上記に記した"休憩時間や隙間時間にできるアプリ"と”大喜利の醍醐味"の２点を満たせていると自負しています。反省としてはもう少しビューのセンスや精度を上げていきたいです。
ありがとうございました。
