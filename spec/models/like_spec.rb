require 'rails_helper'

RSpec.describe Like, type: :model do
  before do
    @like = FactoryBot.build(:like)
  end
  
  describe 'いいね機能' do
  
    context 'いいねできる場合' do
    
      it 'userとanswerが紐付いていればいいねできる' do
        expect(@like).to be_valid
      end
      
    end
    
    context 'いいねできない場合' do
    
      it "userが紐付いていないといいねできない" do
        @like.user = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("User translation missing: ja.activerecord.errors.models.like.attributes.user.required")
      end
    
      it "answerが紐付いていないといいねできない" do
        @like.answer = nil
        @like.valid?
        expect(@like.errors.full_messages).to include("Answer translation missing: ja.activerecord.errors.models.like.attributes.answer.required")
      end
    
    end
      
  end    

end
