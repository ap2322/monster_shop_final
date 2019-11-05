class User::OrdersController < ApplicationController
  before_action :exclude_admin

  def index
    @orders = current_user.orders
  end

  def show
    @order = current_user.orders.find(params[:id])
  end

  def new
    @addresses = user_addresses
  end

  def create
    order = current_user.orders.new(address_params)
    make_order(order)
    flash[:notice] = "Order created successfully!"
    redirect_to '/profile/orders'
  end

  def cancel
    order = current_user.orders.find(params[:id])
    order.cancel
    redirect_to "/profile/orders/#{order.id}"
  end

  def change_address
    @addresses = user_addresses
  end

  def update_address
    order = current_user.orders.find(params[:id])
    order.update(address_params)
    redirect_to "/profile/orders/#{order.id}"
  end

  private
  def address_params
    params.require(:orders).permit(:address_id)
  end

  def make_order(order)
    order.save
      cart.items.each do |item|
        order.order_items.create({
          item: item,
          quantity: cart.count_of(item.id),
          price: item.price
          })
      end
    session.delete(:cart)
  end

  def user_addresses
    current_user.addresses_by_use.map do |address|
      ["#{address.use}: #{address.address}, #{address.city}, #{address.state} #{address.zip}",
        address.id]
    end
  end
end
