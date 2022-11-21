require 'rails_helper'

RSpec.describe "Answers", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_question = Faker::Lorem.sentence
    @question_image = Faker::Lorem.sentence
  end

  context 'お題投稿ができるとき'do
  
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへのボタンがあることを確認する
      expect(page).to have_content('お題投稿')
      # 投稿ページに移動する
      visit new_question_path
      # フォームに情報を入力する
      fill_in 'question[image]', with: @question_image
      fill_in 'question_question', with: @question_question
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容に※画像付き※という文字が存在することを確認する（画像）
      expect(page).to have_content('※画像付き※')
      # トップページには先ほど投稿した内容のお題が存在することを確認する（テキスト）
      expect(page).to have_content(@question_question)
    end
    
  end  
    
  context 'お題投稿ができないとき'do
    
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('お題投稿')
    end
    
  end
  
end
