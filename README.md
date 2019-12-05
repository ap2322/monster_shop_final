# Monster Shop 

Go purchase some monsters and large animals at the [Monster Shop](https://monster-shop-ap.herokuapp.com/). This application was built in Rails as a project to learn how to build discrete applications with a Postgres database using MVC principles.

# Built In
- Rails 5.1.7
- Ruby 2.4.1
- Postgres 11.5

# Setup and configuration
Configuration: Clone this repo and navigate into the project folder. Then run `bundle install` in the terminal to install gems.

Database creation:
Run `bundle exec rake db:{create, migrate, seed}` to set up the database. 

Run the test suite:
Run `rspec` from the terminal to ensure the application is installed correctly and working.

To run locally:
Run `rails s` in the terminal then navigate to your local host.

# Database Schema
![monster_shop_database_schema](https://github.com/ap2322/monster_shop_final/blob/master/Monster%20Shop%20Schema.png?raw=true)

# Features of Monster Shop

#### User Login and Authorization
Users can register and login in order to checkout their cart and create orders. Authentication uses the bcrypt gem to hash passwords for security. User roles include default (shopper), merchant, and admin.

#### Add items to a cart, checkout, designate an address for shipping
Users can add items to a cart, and if logged in, checkout and complete an order by designating an address for checkout. Users will have more than one address associated with their profile. Each address will have a nickname like "home" or "work". Users will choose an address when checking out. A user can edit/add/delete addresses from their profile.

If a user deletes all of their addresses, they cannot check out and see an error telling them they need to add an address first. If an order is still pending, the user can change to which address they want their items shipped.

#### Merchants
Merchants as a storefront have many items in the database. As a logged-in user with a merchant role, the user can add/edit/delete items for the storefront. Merchants cannot delete items that have been ordered.

#### Orders
- 'pending' means a user has placed items in a cart and "checked out" to create an order, merchants may or may not have fulfilled any items yet
- 'packaged' means all merchants have fulfilled their items for the order, and has been packaged and ready to ship
- 'shipped' means an admin has 'shipped' a package and can no longer be cancelled by a user
- 'cancelled' - only 'pending' and 'packaged' orders can be cancelled

#### Admins
Admin users can disable merchants and their items.
