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