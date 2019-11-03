require 'rails_helper'

describe 'All addresses for a user are listed on their Address Index page' do
  before(:each) do
    @user_1 = create(:user, :with_addresses, address_count: 3 )
    @user_2 = create(:user, :with_addresses, address_count: 1 )

  end

  after(:all) do
    User.all.delete_all
    Address.all.delete_all
  end

  describe 'as a logged in user' do
    it 'has a link to see all my addresses from my profile page' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)

      visit "/profile"
      click_link 'My addresses'

      expect(current_path).to eq("/profile/addresses")

      @user_1.addresses.each do |address|
        expect(page).to have_content(address.address)
        expect(page).to have_content(address.city)
        expect(page).to have_content(address.state)
        expect(page).to have_content(address.zip)
      end
    end
  end
end
