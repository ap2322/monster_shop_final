require 'rails_helper'
include ActionView::Helpers::NumberHelper

RSpec.describe 'Order Show Page' do
  describe 'As a Registered User' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @sal = Merchant.create!(name: 'Sals Salamanders', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 1 )
      @user = create(:user)
      @address_1 = create(:address, user_id: @user.id)
      @address_2 = create(:address, user_id: @user.id)
      @address_3 = create(:address, user_id: @user.id)
      @order_1 = @user.orders.create!(address_id: @address_1.id, status: "packaged")
      @order_2 = @user.orders.create!(address_id: @address_2.id, status: "pending")
      @order_item_1 = @order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: true)
      @order_item_2 = @order_2.order_items.create!(item: @giant, price: @hippo.price, quantity: 2, fulfilled: true)
      @order_item_3 = @order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2, fulfilled: false)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    after(:all) do
      User.all.delete_all
      Address.all.delete_all
      Order.all.delete_all
    end

    it 'I can change the address of a pending order' do
      visit "/profile/orders/#{@order_2.id}"

      within ".address" do
        expect(page).to have_content(@address_2.use)
        expect(page).to have_content(@address_2.address)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
        expect(page).to have_content(@address_2.zip)
      end

      click_link "Change Shipping Address"

      expect(current_path).to eq("/profile/orders/#{@order_2.id}/change_address")
      expect(page).to have_content('Please select your shipping address')
      select "home: #{@address_3.address}, Denver, CO 555555", from: 'orders_address_id'
      click_button 'Update Order Shipping Address'

      expect(current_path).to eq("/profile/orders/#{@order_2.id}")

      within ".address" do
        expect(page).to_not have_content(@address_2.address)
        expect(page).to have_content(@address_3.use)
        expect(page).to have_content(@address_3.address)
        expect(page).to have_content(@address_3.city)
        expect(page).to have_content(@address_3.state)
        expect(page).to have_content(@address_3.zip)
      end
    end

    it 'I cannot change the address for an order with any other status than pending' do
      visit "/profile/orders/#{@order_1.id}"

      expect(page).to_not have_link "Change Shipping Address"
    end
  end
end
