require 'rails_helper'

describe 'A User can Add an Address' do
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

  it 'shows a blank form to add an address' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/profile"

    click_link 'Add Address'

    expect(current_path).to eq('/profile/addresses/new')

    fill_in 'Address', with: '234 New Lane'
    fill_in 'City', with: 'Fairview'
    fill_in 'State', with: 'UT'
    fill_in 'Zip', with: '76000'
    select 'other', from: 'Use'
    click_button 'Submit'

    expect(current_path).to eq('/profile')
    expect(page).to have_content('You added an address to your profile!')
    address = @user_1.addresses.last
    within "#address-#{address.id}" do
      expect(page).to have_content('234 New Lane')
      expect(page).to have_content('Fairview')
      expect(page).to have_content('UT')
      expect(page).to have_content('other')
      expect(page).to have_content('76000')
    end
  end

  it 'does not add a new address if a field is left blank' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/profile"

    click_link 'Add Address'

    expect(current_path).to eq('/profile/addresses/new')

    fill_in 'Address', with: nil
    fill_in 'City', with: 'Fairview'
    fill_in 'State', with: 'UT'
    fill_in 'Zip', with: nil
    select 'other', from: 'Use'
    click_button 'Submit'

    expect(page).to have_content("Address can't be blank and Zip can't be blank")
    expect(current_path).to eq('/profile/addresses/new')
  end

end
