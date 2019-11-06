# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

meg_merchant = User.create(name: 'Meg', email: 'meg@merchantemployee.com', password: 'password', merchant_id: megan.id, role: 1)
meg_address_1 = meg_merchant.addresses.create(address: '123 Fake St', city: 'Denver', state: 'Colorado', zip: 80111)
meg_address_2 = meg_merchant.addresses.create(address: '123 Another St', city: 'Denver', state: 'Colorado', zip: 80111, use: 1)

user = User.create(name: 'Bob J', email: 'user@user.com', password: 'password' )
user_address_1 = Address.create(user_id: user.id, address: '123 User St', city: 'Denver', state: 'Colorado', zip: 80111)
user_address_2 = Address.create(user_id: user.id, address: '456 User St', city: 'Longmont', state: 'Colorado', zip: 80111, use: 1)

admin = User.create(name: 'Boss', email: 'admin@admin.com', password: 'adminpassword', role: 2)
