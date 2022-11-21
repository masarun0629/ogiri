require 'rails_helper'

RSpec.describe "Questions", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question_question = Faker::Lorem.sentence
  end

  context 'お題投稿ができるとき'do
  
    it 'ログインしたユーザーはお題投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お題投稿ページへのボタンがあることを確認する
      expect(page).to have_content('お題投稿')
      # 投稿ページに移動する
      visit new_question_path
      # フォームに情報を入力する
      fill_in 'question_question', with: @question_question
      # 投稿するとQuestionモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Question.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容のお題が存在することを確認する
      expect(page).to have_content(@question_question)
    end
    
  end  
    
  context 'お題投稿ができないとき'do
    
    it 'ログインしていないとお題投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # お題投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('お題投稿')
    end
    
  end
  
end

RSpec.describe 'お題削除', type: :system do
  before do
    @question1 = FactoryBot.create(:question)
    @question2 = FactoryBot.create(:question)
  end
  
  context 'お題削除ができるとき' do
    
    it 'ログインしたユーザーは自らが投稿したお題の削除ができる' do
      # お題1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード（6文字以上）', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お題1に「削除」のリンクがあることを確認する
      expect(
        all('.question_list')[1].hover
      ).to have_link '削除', href: question_path(@question1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.question_list')[1].hover.find_link('削除', href: question_path(@question1)).click
      }.to change { Question.count }.by(-1)
      # トップページにリダイレクトしたことを確認する
      expect(current_path).to eq(root_path)
      # トップページに遷移する
      visit root_path
      # トップページにはツイート1の内容が存在しないことを確認する
      expect(page).to have_no_content("#{@question1.question}")
    end
    
  end
  
  context 'お題削除ができないとき' do
    
    it 'ログインしたユーザーは自分以外が投稿したお題の削除ができない' do
      # お題1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @question1.user.email
      fill_in 'パスワード（6文字以上）', with: @question1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # お題2に「削除」のリンクがないことを確認する
      expect(
        all('.question_list')[0].hover
      ).to have_no_link '削除', href: question_path(@question2)
    end
    
    it 'ログインしていないとお題の削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # お題1に「削除」のリンクがないことを確認する
      expect(
        all('.question_list')[1].hover
      ).to have_no_link '削除', href: question_path(@question1)
      # お題2に「削除」のリンクがないことを確認する
      expect(
        all('.question_list')[1].hover
      ).to have_no_link '削除', href: question_path(@question2)
    end
    
  end
  
end
