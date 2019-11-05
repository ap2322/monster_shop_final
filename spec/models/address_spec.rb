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

      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )

      @order_1 = @user.orders.create!(address_id: @address_1.id, status: 'shipped')
      @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)

    end

    it 'names the first address as home' do
      expect(@address_1.use).to eq('home')
      expect(@address_2.use).to_not eq('home')
    end

    it 'returns boolean for has_shipped_order?' do
      expect(@address_1.has_shipped_order?).to be_truthy
      expect(@address_2.has_shipped_order?).to be_falsey
    end
  end
end
