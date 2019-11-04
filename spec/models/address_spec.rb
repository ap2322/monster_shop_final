require 'rails_helper'

RSpec.describe Address do
  describe 'Relationships' do
    it {should belong_to :user}
    it {should have_many :orders}
  end

  describe 'Validations' do
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zip}
  end

  describe 'instance methods' do
    before(:each) do
      @user = create(:user)
      @address_1 = create(:address, user_id: @user.id)
      @address_2 = create(:address, user_id: @user.id, use: 1)
    end

    it 'names the first address as home' do
      expect(@address_1.use).to eq('home')
      expect(@address_2.use).to_not eq('home')
    end
  end
end
