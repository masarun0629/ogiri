require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  
  describe 'ユーザー新規登録' do
    
    context '新規登録できる場合' do
      
      it 'すべての値が正確に入力されていれば登録できる' do
        expect(@user).to be_valid
      end
      
    end
    
    context '新規登録できない場合' do
      
      it "nicknameが空では登録できない" do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname translation missing: ja.activerecord.errors.models.user.attributes.nickname.blank")
      end
      
      it "profileが空では登録できない" do
        @user.profile = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Profile translation missing: ja.activerecord.errors.models.user.attributes.profile.blank")
      end
      
      it "emailが空では登録できない" do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email translation missing: ja.activerecord.errors.models.user.attributes.email.blank")
      end
      
      it "passwordが空では登録できない" do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password translation missing: ja.activerecord.errors.models.user.attributes.password.blank")
      end
      
      it 'passwordが5文字以下では登録できない' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password translation missing: ja.activerecord.errors.models.user.attributes.password.too_short')
      end
      
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '12345a'
        @user.password_confirmation = '123456a'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation translation missing: ja.activerecord.errors.models.user.attributes.password_confirmation.confirmation")
      end
      
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email translation missing: ja.activerecord.errors.models.user.attributes.email.taken')
      end
  
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email translation missing: ja.activerecord.errors.models.user.attributes.email.invalid')
      end
      
      it "nickname11文字以上では登録できない" do
        @user.nickname = "まさるんまさるんまさる"
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname translation missing: ja.activerecord.errors.models.user.attributes.nickname.too_long")
      end
      
      it "prifileが101文字以上では登録できない" do
        @user.profile = "#{"あ"*101}"
        @user.valid?
        expect(@user.errors.full_messages).to include("Profile translation missing: ja.activerecord.errors.models.user.attributes.profile.too_long")
      end
      
    end  
      
  end    
    
end
