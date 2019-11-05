require 'rails_helper'

describe 'A User can Delete their Addresses' do
  before(:each) do
    @user_1 = create(:user)
    @address_1 = create(:address, user_id: @user_1.id)
    @address_2 = create(:address, user_id: @user_1.id, use: 2)
    @address_3 = create(:address, user_id: @user_1.id, use: 1)
  end

  after(:all) do
    User.all.delete_all
    Address.all.delete_all
  end

  it 'shows a pre-populated form to edit an address' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/profile"

    expect(page).to have_content(@address_1.address)

    within "#address-#{@address_1.id}" do
      click_button "Delete"
    end

    expect(page).to_not have_content(@address_1.address)
    expect(page).not_to have_selector("#address-#{@address_1.id}")
    expect(page).to have_selector("#address-#{@address_2.id}")

  end

end
