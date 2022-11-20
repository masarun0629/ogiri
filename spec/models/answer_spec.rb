require 'rails_helper'

RSpec.describe Answer, type: :model do
  before do
    @answer = FactoryBot.build(:answer)
  end
  
  describe '回答投稿機能' do
  
    context '投稿できる場合' do
    
      it 'すべての値が正確に入力されていれば投稿できる' do
        expect(@answer).to be_valid
      end
      
    end 
    
    context '投稿できる場合' do
    
      it "answerが空では登録できない" do
        @answer.answer = ''
        @answer.valid?
        expect(@answer.errors.full_messages).to include("Answer translation missing: ja.activerecord.errors.models.answer.attributes.answer.blank")
      end
      
      it "answerが73文字以上では登録できない" do
        @answer.answer = "#{"あ"*73}"
        @answer.valid?
        expect(@answer.errors.full_messages).to include("Answer translation missing: ja.activerecord.errors.models.answer.attributes.answer.too_long")
      end
      
      it "userが紐付いていないと投稿できない" do
        @answer.user = nil
        @answer.valid?
        expect(@answer.errors.full_messages).to include("User translation missing: ja.activerecord.errors.models.answer.attributes.user.required")
      end
      
      it "questionが紐付いていないと投稿できない" do
        @answer.question = nil
        @answer.valid?
        expect(@answer.errors.full_messages).to include("Question translation missing: ja.activerecord.errors.models.answer.attributes.question.required")
      end
      
    end 
  
  end  

end

