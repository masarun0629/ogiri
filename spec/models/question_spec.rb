require 'rails_helper'

RSpec.describe Question, type: :model do
  before do
    @question = FactoryBot.build(:question)
  end
  
  describe 'お題投稿機能' do
  
    context '投稿できる場合' do
      
      it 'すべての値が正確に入力されていれば投稿できる' do
        expect(@question).to be_valid
      end
      
      it '画像がなくても投稿できる' do
        @question.image = nil
        expect(@question).to be_valid
      end
      
    end
    
    context '投稿できない場合' do
      
      it "questionが空では登録できない" do
        @question.question = ''
        @question.valid?
        expect(@question.errors.full_messages).to include("Question translation missing: ja.activerecord.errors.models.question.attributes.question.blank")
      end
      
      it "questionが81文字以上では登録できない" do
        @question.question = "#{"あ"*81}"
        @question.valid?
        expect(@question.errors.full_messages).to include("Question translation missing: ja.activerecord.errors.models.question.attributes.question.too_long")
      end
      
      it 'userが紐付いていないと保存できない' do
        @question.user = nil
        @question.valid?
        expect(@question.errors.full_messages).to include("User translation missing: ja.activerecord.errors.models.question.attributes.user.required")
      end
      
    end
  
  end
    
end
