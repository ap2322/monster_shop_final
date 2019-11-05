require 'rails_helper'

describe 'All addresses for a user are listed on their Address Index page' do
  before(:each) do
    @user_1 = create(:user)
    @address_1 = create(:address, user_id: @user_1.id)
    @address_2 = create(:address, user_id: @user_1.id, use: 2)
    @address_3 = create(:address, user_id: @user_1.id, use: 1)
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20.25, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
  end

  after(:all) do
    User.all.delete_all
    Address.all.delete_all
    Merchant.all.delete_all
    Item.all.delete_all
  end

  describe 'as a logged in user' do
    it 'I can see all my addresses from my profile page' do

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"

      @user_1.addresses.each do |address|
        expect(page).to have_content(address.use)
        expect(page).to have_content(address.address)
        expect(page).to have_content(address.city)
        expect(page).to have_content(address.state)
        expect(page).to have_content(address.zip)
      end
    end

    it 'lists the addresses of a user in order of address use' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"

      within "li.addresses:nth-child(1)" do
        expect(page).to have_content(@address_1.use)
        expect(page).to have_content(@address_1.address)
        expect(page).to have_content(@address_1.city)
        expect(page).to have_content(@address_1.state)
      end

      within "li.addresses:nth-child(2)" do
        expect(page).to have_content(@address_3.use)
        expect(page).to have_content(@address_3.address)
        expect(page).to have_content(@address_3.city)
        expect(page).to have_content(@address_3.state)
      end

      within "li.addresses:nth-child(3)" do
        expect(page).to have_content(@address_2.use)
        expect(page).to have_content(@address_2.address)
        expect(page).to have_content(@address_2.city)
        expect(page).to have_content(@address_2.state)
      end
    end

    it 'has a link to add an address to my profile' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"

      expect(page).to have_link("Add Address")
    end

    it 'has a button to edit each address next to each address' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"
      @user_1.addresses.each do |address|
        expect(page).to have_button("Edit")
      end
    end

    it 'has a button to delete each address next to each address' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"
      @user_1.addresses.each do |address|
        expect(page).to have_button("Delete")
      end
    end

    it 'hides the edit and delete buttons if an address is in a shipped order' do
      order_1 = @user_1.orders.create!(address_id: @address_1.id, status: 'shipped')
      order_1.order_items.create!(item: @ogre, price: @ogre.price, quantity: 2)

      order_2 = @user_1.orders.create!(address_id: @address_2.id, status: 'pending')
      order_2.order_items.create!(item: @ogre, price: @ogre.price, quantity: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
      visit "/profile"

      within "#address-#{@address_1.id}" do
        expect(page).to have_content(@address_1.use)
        expect(page).to have_content(@address_1.address)
        expect(page).to have_content(@address_1.city)
        expect(page).to have_content(@address_1.state)
        expect(page).to_not have_button "Edit"
        expect(page).to_not have_button "Delete"
      end

      within "#address-#{@address_2.id}" do
        expect(page).to have_button "Edit"
        expect(page).to have_button "Delete"
      end

      within "#address-#{@address_3.id}" do
        expect(page).to have_button "Edit"
        expect(page).to have_button "Delete"
      end

    end
  end
end
