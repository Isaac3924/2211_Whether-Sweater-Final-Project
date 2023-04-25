require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
  
    it { should have_secure_password }
  end


  describe 'instance methods' do
    it 'can find a user by email' do
      user = User.create!(email: 'email@email.com', password: 'password', password_confirmation: 'password')

      expect(user.find_by_email(user.email)).to eq(user)
    end
  end
end