class Address < ApplicationRecord
  belongs_to :user
  has_many :orders

  validates_presence_of :address,
                        :city,
                        :state,
                        :zip

  enum use: ['home', 'business', 'other']

  def has_shipped_order?
    !orders.where(status: 'shipped').empty?
  end
end
