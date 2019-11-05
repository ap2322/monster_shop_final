require 'rails_helper'

describe 'A User can Edit their Addresses' do
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

    within "#address-#{@address_1.id}" do
      click_button "Edit"
    end

    expect(current_path).to eq "/profile/addresses/#{@address_1.id}/edit"
    expect(find_field('Address').value).to eq @address_1.address
    expect(find_field('City').value).to eq @address_1.city
    expect(find_field('State').value).to eq @address_1.state
    expect(find_field('Zip').value).to eq "#{@address_1.zip}"
    expect(find_field('Use').value).to eq @address_1.use
  end

  it 'allows me to change my address and shows me the changed address on my profile page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/profile/addresses/#{@address_1.id}/edit"

    fill_in 'Address', with: '456 Nowhere Blvd'
    fill_in 'City', with: 'Billings'
    fill_in 'State', with: 'Montana'
    fill_in 'Zip', with: '80000'
    select 'business', from: 'Use'
    click_button 'Submit'

    expect(current_path).to eq '/profile'
    expect(page).to have_content '456 Nowhere Blvd'
    expect(page).to have_content 'Billings'
    expect(page).to have_content 'Montana'
    expect(page).to have_content 'business'
    expect(page).to_not have_content @address_1.address
  end

  it 'throws an error message if a field is nil' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
    visit "/profile/addresses/#{@address_1.id}/edit"

    fill_in 'Address', with: nil
    click_button 'Submit'

    expect(page).to have_content "Address can't be blank"
  end
end
