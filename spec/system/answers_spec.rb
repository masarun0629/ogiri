require 'rails_helper'

RSpec.describe "回答投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(:question)
    @answer_answer = Faker::Lorem.sentence
  end

  context '回答投稿ができるとき'do
  
    it 'ログインしたユーザーは回答投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 回答投稿ページへのボタンがあることを確認する
      expect(page).to have_content('回答ページへ')
      # 回答投稿ページに移動する
      visit question_answers_path(@question.id)
      # フォームに情報を入力する
      fill_in 'answer_answer', with: @answer_answer
      # 投稿するとAnswerモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Answer.count }.by(1)
      # 回答投稿ページにリダイレクトすることを確認する
      expect(current_path).to eq(question_answers_path(@question.id))
      # 回答投稿ページには先ほど投稿した内容の回答が存在することを確認する
      expect(page).to have_content(@answer_answer)
    end
    
  end  
    
  context '回答投稿ができないとき'do
    
    it 'ログインしていないと回答投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 回答投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content('回答ページへ')
    end
    
  end
  
end

RSpec.describe '回答削除', type: :system do
  before do
    @question = FactoryBot.create(:question)
    #@answer_answer = Faker::Lorem.sentence
    @answer1 = FactoryBot.create(:answer)
    @answer2 = FactoryBot.create(:answer)
  end
  
  context '回答削除ができるとき' do
    
    it 'ログインしたユーザーは自らが投稿した回答の削除ができる' do
      # 回答1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @answer1.user.email
      fill_in 'パスワード（6文字以上）', with: @answer1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      
      # 回答投稿ページに移動する
      visit question_answers_path(@question.id)
      
      # フォームに情報を入力する
      fill_in 'answer_answer', with: @answer1.answer
      
      # 投稿するとAnswerモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Answer.count }.by(1)
      
      # 回答投稿ページにリダイレクトすることを確認する
      expect(current_path).to eq(question_answers_path(@question.id))
      
      # 回答投稿ページには先ほど投稿した内容の回答が存在することを確認する
      expect(page).to have_content(@answer1.answer)
      
      # 回答1に「削除」のリンクがあることを確認する
      expect(
        all('.answer_list')[0].hover
      ).to have_link '削除', href: question_answer_path(@question.id,@answer1.id)
    
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        all('.answer_list')[0].hover.find_link('削除', href: question_answer_path(@question.id,@answer1.id)).click
      }.to change { Answer.count }.by(-1)
      
      # 回答投稿ページにリダイレクトしたことを確認する
      expect(current_path).to eq(question_answers_path(@question.id))
      # 回答投稿ページには回答1の内容がしないことを確認する
      expect(page).to have_no_content("#{@answer1.answer}")
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
