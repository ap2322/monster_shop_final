require 'rails_helper'

RSpec.describe User do
  describe 'Relationships' do
    it {should belong_to(:merchant).optional}
    it {should have_many :orders}
    it {should have_many :addresses}
  end

  describe 'Validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_uniqueness_of :email}
  end

  describe 'instance methods' do
    before(:each) do
      @user = create(:user)
      @address_1 = create(:address, user_id: @user.id)
      @address_2 = create(:address, user_id: @user.id, use: 2)
      @address_3 = create(:address, user_id: @user.id, use: 1)
    end
    it 'should sort user addresses by use' do
      expected = [@address_1, @address_3, @address_2]
      expect(@user.addresses_by_use).to eq expected
    end
  end
end
